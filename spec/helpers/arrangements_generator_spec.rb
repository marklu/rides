require 'spec_helper'

describe ArrangementsGenerator do
  before(:each) do
    origin = create_valid!(Location, :latitude => 37.875535, :longitude => -122.255618)
    destination = create_valid!(Location, :latitude => 37.867417, :longitude => -122.260408)

    @passenger1 = create_valid!(Person,
      :location => create_valid!(Location, :latitude => 37.866054, :longitude => -122.254856)
    )
    @passenger2 = create_valid!(Person,
      :location => create_valid!(Location, :latitude => 37.8555404, :longitude => -122.2664398)
    )

    @empty_arrangement = build_valid(Arrangement,
      :origin => origin,
      :destination => destination
    )
    @empty_arrangement.stub(:capacity).and_return(1)
    @empty_arrangement.stub(:full?).and_return(false)
    @empty_arrangement.stub(:incompatibility_with).and_return(1.0)

    @full_arrangement = build_valid(Arrangement,
      :origin => origin,
      :destination => destination
    )
    @full_arrangement.stub(:full?).and_return(true)

    @half_full_arrangement = build_valid(Arrangement,
      :origin => origin,
      :destination => destination
    )
    @half_full_arrangement.passengers << @passenger1
    @half_full_arrangement.stub(:capacity).and_return(2)
    @half_full_arrangement.stub(:full?).and_return(false)
  end
  
  context "generating distance matrix" do
    it "returns an empty hash for an argument with no arrangements" do
      arrangements = []
      passengers = [@passenger1]
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_empty
    end
    
    it "returns an empty hash for an argument with no passengers" do
      arrangements = [@empty_arrangement]
      passengers = []
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_empty
    end
    
    it "returns a hash for a valid argument with empty arrangement" do
      arrangements = [@empty_arrangement]
      passengers = [@passenger2]
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_a_kind_of(Hash)
      distance_matrix.length.should == 6
    end
    
    it "returns a hash for a valid argument with filled arrangement" do
      arrangements = [@half_full_arrangement]
      passengers = [@passenger2]
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_a_kind_of(Hash)
      distance_matrix.length.should == 12
    end
    
    it "returns a hash for a valid argument with multiple arrangements" do
      arrangements = [@empty_arrangement, @half_full_arrangement]
      passengers = [@passenger2]
      distance_matrix = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      distance_matrix.should be_a_kind_of(Hash)
      distance_matrix.length.should == 16
    end
  end
  
  context "scoring a path" do
    it "returns no score for an argument with empty paths" do
      path = []
      distances = ArrangementsGenerator.generate_distance_matrix([@empty_arrangement], [@passenger1])
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
      distances = ArrangementsGenerator.generate_distance_matrix([@empty_arrangement], [@passenger1])
      path_score = ArrangementsGenerator.score_path(path, distances)
      path_score.should == 0
    end
    
    it "returns a score for a valid argument" do
      
      path = [@empty_arrangement, @passenger1, @empty_arrangement.destination]
      distances = ArrangementsGenerator.generate_distance_matrix([@empty_arrangement], [@passenger1])
      path_score = ArrangementsGenerator.score_path(path, distances)
      path_score.should == 0.6219967665051265
    end
  end
  
  context "scoring incompatibility" do
    it "returns no score for an argument with empty paths" do
      passengers = []
      incompatibility_score = ArrangementsGenerator.score_incompatibility(passengers)
      incompatibility_score.should == 0
    end
    
    it "returns no score for an argument with one passenger" do
      passengers = [@passenger1]
      incompatibility_score = ArrangementsGenerator.score_incompatibility(passengers)
      incompatibility_score.should == 0
    end
    
    it "returns a score for a valid argument" do
      passengers = [@empty_arrangement, @passenger1]
      incompatibility_score = ArrangementsGenerator.score_incompatibility(passengers)
      incompatibility_score.should == 1.0
    end
  end
  
  context "generating a path" do
    it "returns the original path for an argument with full arrangement" do
      current_arrangements = @full_arrangement
      assigned_passengers = [@passenger1]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should be_empty
    end
    
    it "returns the original path for an argument with more passengers than arrangement capacity" do
      current_arrangements = @half_full_arrangement
      assigned_passengers = [@passenger1, @passenger2]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should == [@passenger1]
    end
    
    it "returns the original path for an argument with no assigned passengers" do
      current_arrangements = @empty_arrangement
      assigned_passengers = []
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should be_empty
    end
    
    it "returns a path for an argument with empty arrangement and one assigned passenger" do
      current_arrangements = @empty_arrangement
      assigned_passengers = [@passenger1]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should == [@passenger1]
    end
    
    it "returns a path for a valid argument" do
      current_arrangements = @half_full_arrangement
      assigned_passengers = [@passenger2]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangements], assigned_passengers)
      path, path_score = ArrangementsGenerator.generate_path(current_arrangements, assigned_passengers, distances)
      path.should include @passenger1
      path.should include @passenger2
    end
  end
    
  context "generating an arrangement" do
    it "returns the original arrangement and remaining passenger for an argument with full arrangement" do
      current_arrangement = @full_arrangement
      remaining_passengers = [@passenger1]
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangement], remaining_passengers)
      new_arrangement, new_remaining_passengers = ArrangementsGenerator.generate_arrangement(current_arrangement, remaining_passengers, distances)
      new_arrangement.should == current_arrangement
      new_remaining_passengers.should == remaining_passengers
    end
    
    it "returns the original arrangement for an argument with no passengers" do
      current_arrangement = @empty_arrangement
      remaining_passengers = []
      distances = ArrangementsGenerator.generate_distance_matrix([current_arrangement], remaining_passengers)
      new_arrangement, new_remaining_passengers = ArrangementsGenerator.generate_arrangement(current_arrangement, remaining_passengers, distances)
      new_arrangement.should == current_arrangement
      new_remaining_passengers.should be_empty
    end
    
    it "returns a modified arrangement for a valid argument" do
      current_arrangement = @empty_arrangement
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
      arrangements = [@empty_arrangement]
      passengers = []
      new_arrangements = ArrangementsGenerator.generate_arrangements(arrangements, passengers)
      new_arrangements.should == arrangements
    end
    
    it "returns modified arrangements for a valid argument" do
      arrangements = [@empty_arrangement, @full_arrangement]
      passengers = [@passenger1, @passenger2]
      new_arrangements = ArrangementsGenerator.generate_arrangements(arrangements, passengers)
      new_arrangements.length.should == 2
    end
  end
end