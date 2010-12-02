require 'spec_helper'

describe Arrangement do
  before(:each) do
    @arrangement = Arrangement.create!
  end

  context "when determining incompatibility" do
    context "with annother arrangement" do
      before(:each) do
        @arrangement_preferences = Arrangement.create!
        @arrangement.stub(:preferences).and_return(@arrangement_preferences)
        @other = Arrangement.create!
        @other_preferences = Preferences.create!
        @other.stub(:preferences).and_return(@other_preferences)
      end

      it "compares the other arrangement's preferences with its own" do
        @arrangement_preferences.should_receive(:incompatibility_with).with(@other_preferences)
        @arrangement.incompatibility_with(@other)
      end
    end

    context "with a person" do
      before(:each) do
        @arrangement_preferences = Arrangement.create!
        @arrangement.stub(:preferences).and_return(@arrangement_preferences)
        @other = create_valid!("Person")
        @other_preferences = Preferences.create!
        @other.stub(:preferences).and_return(@other_preferences)
      end
  
      it "compares the person's preferences with its own" do
        @arrangement_preferences.should_receive(:incompatibility_with).with(@other_preferences)
        @arrangement.incompatibility_with(@other)
      end
    end

    context "when has no driver" do
      it "has neutral preferences" do
        preferences = @arrangement.preferences
        [:music, :smoking].each do |preference|
          preferences.send(preference).should == 'no_preference'
        end
      end
    end

    context "when has a driver" do
      before(:each) do
        @preferences = Preferences.create!
        @arrangement.stub_chain(:driver, :preferences).and_return(@preferences)
      end

      it "has the same preferences as the driver" do
        @arrangement.preferences.should eq(@preferences)
      end
    end
  end
end
