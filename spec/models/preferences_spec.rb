require 'spec_helper'

describe Preferences do
  before(:each) do
    @preferences = Preferences.create!
  end

  context "when creating" do
    it "sets preferences to 'No Preference' by default" do
      person = create_valid(Person)
      [:music, :smoking].each do |preference|
        person.preferences.send(preference).should == 'no_preference'
      end
    end
  end

  context "when validating" do
    it "is valid with a valid music preference (No Preference, No Music, Quiet Music, Loud Music)" do
      ['no_preference', 'no_music', 'quiet_music', 'loud_music'].each do |preference|
        @preferences.music = preference
        @preferences.should be_valid
      end
    end

    it "is not valid with an invalid music preference" do
      ['No Preference', 'invalid', '0'].each do |preference|
        @preferences.music = preference
        @preferences.should_not be_valid
      end
    end

    it "is valid with a valid smoking preference (No Preference, No Smoking, Smoking)" do
      ['no_preference', 'no_smoking', 'smoking'].each do |preference|
        @preferences.smoking = preference
        @preferences.should be_valid
      end
    end

    it "is not valid with an invalid smoking preference" do
      ['No Preference', 'invalid', '0'].each do |preference|
        @preferences.smoking = preference
        @preferences.should_not be_valid
      end
    end
  end

  context "when determining incompatibility with another set of preferences" do
    before(:each) do
      @other = Preferences.create!
    end

    context "when one set has neutral preferences" do
      it "has 0 incompatibility with the other set" do
        @other.music = 'no_music'
        @other.smoking = 'no_smoking'
        @preferences.incompatibility_with(@other).should == 0
        @other.incompatibility_with(@preferences).should == 0
      end
    end

    context "when both sets have the same preferences" do
      it "has 0 incompatibility with the other set" do
        [
          ['no_music', 'no_smoking'],
          ['quiet_music', 'no_smoking'],
          ['load_music', 'smoking']
        ].each do |music_pref, smoking_pref|
          @preferences.music = music_pref
          @preferences.smoking = smoking_pref
          @preferences.incompatibility_with(@other).should == 0
          @other.incompatibility_with(@preferences).should == 0
        end
      end
    end

    context "when one set has 'No Music' and 'No Smoking' and the other has 'Quiet Music' and 'No Smoking'" do
      it "has 0.25 incompatibility with the other set" do
        @preferences.music = 'no_music'
        @preferences.smoking = 'no_smoking'
        @other.music = 'quiet_music'
        @other.smoking = 'no_smoking'
        @preferences.incompatibility_with(@other).should == 0.25
        @other.incompatibility_with(@preferences).should == 0.25
      end
    end

    context "when one set has 'Quiet Music' and 'No Smoking' and the other has 'Loud Music' and 'No Smoking'" do
      it "has 0.25 incompatibility with the other set" do
        @preferences.music = 'quiet_music'
        @preferences.smoking = 'no_smoking'
        @other.music = 'loud_music'
        @other.smoking = 'no_smoking'
        @preferences.incompatibility_with(@other).should == 0.25
        @other.incompatibility_with(@preferences).should == 0.25
      end
    end

    context "when one set has 'No Music' and 'No Smoking' and the other has 'Quiet Music' and 'Smoking'" do
      it "has 0.75 incompatibility with the other set" do
        @preferences.music = 'no_music'
        @preferences.smoking = 'no_smoking'
        @other.music = 'quiet_music'
        @other.smoking = 'smoking'
        @preferences.incompatibility_with(@other).should == 0.75
        @other.incompatibility_with(@preferences).should == 0.75
      end
    end

    context "when one set has 'No Music' and 'No Smoking' and the other has 'Loud Music' and 'Smoking'" do
      it "has 1.0 incompatibility with the other set" do
        @preferences.music = 'no_music'
        @preferences.smoking = 'no_smoking'
        @other.music = 'loud_music'
        @other.smoking = 'smoking'
        @preferences.incompatibility_with(@other).should == 1.0
        @other.incompatibility_with(@preferences).should == 1.0
      end
    end
  end
end
