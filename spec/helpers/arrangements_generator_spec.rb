require 'spec_helper'

describe ArrangementsGenerator do
  before(:each) do
    @start = Location.create!(:location => '2700 Hearst Avenue, Berkeley, CA')
    @start.stub!(:latitude).and_return(37.875535)
    @start.stub!(:longitude).and_return(-122.255618)
    @finish = Location.create!(:location => '2400 Durant Avenue, Berkeley, CA')
    @finish.stub!(:latitude).and_return(37.867417)
    @finish.stub!(:longitude).and_return(-122.260408)
    @passenger1_loc = Location.create!(:location => '2650 Haste Street, Berkeley, CA')
    @passenger1_loc.stub!(:latitude).and_return(37.866054)
    @passenger1_loc.stub!(:longitude).and_return(-122.254856)
    @passenger2_loc = Location.create!(:location => '2995 Shattuck Avenue, Berkeley, CA')
    @passenger2_loc.stub!(:latitude).and_return(37.8555404)
    @passenger2_loc.stub!(:longitude).and_return(-122.2664398)
    
    @passenger1 = create_valid!(Person)
    @passenger1.email = "random1@rand.org"
    @passenger1.stub(:location).and_return(@passenger1_loc)
    @passenger2 = create_valid!(Person)
    @passenger2.email = "random2@rand.org"
    @passenger2.stub(:location).and_return(@passenger2_loc)
    
    # empty arrangement
    @arrangement_empty = Arrangement.new
    @arrangement_empty.stub!(:origin).and_return(@start)
    @arrangement_empty.stub!(:destination).and_return(@finish)
    @arrangement_empty.stub!(:capacity).and_return(1)
    @arrangement_empty.stub!(:full?).and_return(false)
    
    # full arrangement
    @arrangement_full = Arrangement.new
    @arrangement_full.stub!(:origin).and_return(@start)
    @arrangement_full.stub!(:destination).and_return(@finish)
    @arrangement_full.stub!(:full?).and_return(true)
    
    # partially-filled
    @arrangement_fill = Arrangement.new
    @arrangement_fill.passengers << @passenger1
    @arrangement_fill.stub!(:origin).and_return(@start)
    @arrangement_fill.stub!(:destination).and_return(@finish)
    @arrangement_fill.stub!(:capacity).and_return(2)
    @arrangement_fill.stub!(:full?).and_return(false)
  end
  
  context "generating distance matrix" do
    it "returns an empty hash for an argument with no arrangements" do
      arrangements = []
      passengers = [@passenger1]
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_empty
    end
    
    it "returns an empty hash for an argument with no passengers" do
      arrangements = [@arrangement_empty]
      passengers = []
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_empty
    end
    
    it "returns a hash for a valid argument with empty arrangement" do
      arrangements = [@arrangement_empty]
      passengers = [@passenger2]
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_a_kind_of(Hash)
      distance_matrix.length.should == 6
    end
    
    it "returns a hash for a valid argument with filled arrangement" do
      arrangements = [@arrangement_fill]
      passengers = [@passenger2]
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_a_kind_of(Hash)
      distance_matrix.length.should == 12
    end
    
    it "returns a hash for a valid argument with multiple arrangements" do
      arrangements = [@arrangement_empty, @arrangement_fill]
      passengers = [@passenger2]
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_a_kind_of(Hash)
      distance_matrix.length.should == 16
    end
  end
  
  context "scoring a path" do
    it "returns no score for an argument with empty paths" do
      path = []
      distances = ArrangementsGenerator.generate_distance_matrix([@arrangement_empty], [@passenger1])
      path_score = ArrangementsGenerator.score_path(path, distances)
      path_score.should == 0
    end
    
    it "returns no score for an argument with empty distance matrix" do
      path = [@passenger1]
      distances = Hash.new
      path_score = ArrangementsGenerator.score_path(path, distances)
      path_score.should == 0
    end
    
    it "returns no score for an argument with one-entry path" do
      path = [@passenger1]
      distances = ArrangementsGenerator.generate_distance_matrix([@arrangement_empty], [@passenger1])
      path_score = ArrangementsGenerator.score_path(path, distances)
      path_score.should == 0
    end
    
    it "returns a score for a valid argument" do
      path = [@arrangement_empty, @passenger1, @arrangement_empty.destination]
      distances = ArrangementsGenerator.generate_distance_matrix([@arrangement_empty], [@passenger1])
      path_score = ArrangementsGenerator.score_path(path, distances)
      path_score.should == 0.9728525291798945
    end
  end
  
  context "generating a path" do
    it "returns the original path for an argument with full arrangement" do
      current_arrangements = @arrangement_full
      assigned_passengers = [@passenger1]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should be_empty
    end
    
    it "returns the original path for an argument with more passengers than arrangement capacity" do
      current_arrangements = @arrangement_fill
      assigned_passengers = [@passenger1, @passenger2]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should == [@passenger1]
    end
    
    it "returns the original path for an argument with no assigned passengers" do
      current_arrangements = @arrangement_empty
      assigned_passengers = []
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should be_empty
    end
    
    it "returns a path for an argument with empty arrangement and one assigned passenger" do
      current_arrangements = @arrangement_empty
      assigned_passengers = [@passenger1]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should == [@passenger1]
    end
    
    it "returns a path for a valid argument" do
      current_arrangements = @arrangement_fill
      assigned_passengers = [@passenger2]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should include @passenger1
      path.should include @passenger2
    end
  end
    
  context "generating an arrangement" do
    it "returns the original arrangement and remaining passenger for an argument with full arrangement" do
      current_arrangement = @arrangement_full
      remaining_passengers = [@passenger1]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangement], remaining_passengers)
      new_arrangement, new_remaining_passengers = ArrangementsGenerator.generate_arrangement(current_arrangement, remaining_passengers, distances)
      new_arrangement.should == current_arrangement
      new_remaining_passengers.should == remaining_passengers
    end
    
    it "returns the original arrangement for an argument with no passengers" do
      current_arrangement = @arrangement_empty
      remaining_passengers = []
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangement], remaining_passengers)
      new_arrangement, new_remaining_passengers = ArrangementsGenerator.generate_arrangement(current_arrangement, remaining_passengers, distances)
      new_arrangement.should == current_arrangement
      new_remaining_passengers.should be_empty
    end
    
    it "returns a modified arrangement for a valid argument" do
      current_arrangement = @arrangement_empty
      remaining_passengers = [@passenger1, @passenger2]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangement], remaining_passengers)
      new_arrangement, new_remaining_passengers = ArrangementsGenerator.generate_arrangement(current_arrangement, remaining_passengers, distances)
      new_arrangement.passengers.length.should == 1
      new_remaining_passengers.length.should == 1
    end
  end
  
  context "generating arrangements" do
    it "returns an empty list for an argument with no arrangements" do
      arrangements = []
      passengers = [@passenger1, @passenger2]
      new_arrangements = ArrangementsGenerator.generate_arrangements(arrangements, passengers)
      new_arrangements.should be_empty
    end
    
    it "returns the original arrangements for an argument with no passengers" do
      arrangements = [@arrangement_empty]
      passengers = []
      new_arrangements = ArrangementsGenerator.generate_arrangements(arrangements, passengers)
      new_arrangements.should == arrangements
    end
    
    it "returns modified arrangements for a valid argument" do
      arrangements = [@arrangement_empty, @arrangement_full]
      passengers = [@passenger1, @passenger2]
      new_arrangements = ArrangementsGenerator.generate_arrangements(arrangements, passengers)
      new_arrangements.length.should == 2
    end
  end
end