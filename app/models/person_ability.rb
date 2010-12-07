class PersonAbility
  include CanCan::Ability

  def initialize(person)
    # Devise handles abilities of those who are not signed in
    # CanCan only handles abilities pertaining to specific trip instances
    #   and their arrangements.
    if !person.nil?
      # Can View Trip
      can [:show, :participants], Trip do |trip|
        trip.participants.include?(person) ||
        trip.organizer == person
      end

      # Can Manage Trip Participantship
      can [:leave], Trip do |trip|
        trip.participants.include?(person) ||
        trip.organizer == person
      end

      # Can Manage Trip
      can [:edit, :update, :destroy, :invite], Trip do |trip|
        trip.organizer == person
      end

      # Can View Trip Arrangements
      can [:index, :show], Arrangement do |arrangement|
        arrangement.trip.participants.include?(person) ||
        arrangement.trip.organizer == person
      end

      # Can Manage Trip Arrangements
      can [:generate], Arrangement do |arrangement|
        arrangement.trip.organizer == person
      end
    end
  end
end