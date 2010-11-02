require 'spec_helper'

describe Person do

  before(:each) do
#    @current_user = mock_model(Person, {:id => 1})
  end

  describe "when validating a person" do
    it "should not allow a person with no name" do
      @no_name_attributes = {

      }
      @person = Person.new(@no_name_attributes)
      @person.should_not be_valid
    end



  end


end
