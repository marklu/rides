class Preferences < ActiveRecord::Base
  TYPES = [:music, :smoking]
  METRICS = {
    'no_music' => 0, 'quiet_music' => 0.5, 'loud_music' => 1,
    'no_smoking' => 0, 'smoking' => 1
  }

  after_initialize :set_default_preferences

  validates :music,
    :inclusion => {
      :in => ['no_preference', 'no_music', 'quiet_music', 'loud_music'],
      :message => "must be one of No Preference, No Music, Quiet Music, or Loud Music"
    }
  validates :smoking,
    :inclusion => {
      :in => ['no_preference', 'no_smoking', 'smoking'],
      :message => "must be one of No Preference, No Smoking, or Smoking"
    }

  belongs_to :person

  def incompatibility_with(other)
    score = 0.0
    TYPES.each do |type|
      my_pref = self.send(type)
      other_pref = other.send(type)
      unless my_pref == 'no_preference' || other_pref == 'no_preference'
        score += (METRICS[my_pref] - METRICS[other_pref]).abs
      end
    end
    score / TYPES.count
  end

  def set_default_preferences
    self.music ||= 'no_preference'
    self.smoking ||= 'no_preference'
  end
end
