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
        trip.organizers.include?(person)
      end

      # Can Manage Trip Membership
      can [:manage_membership, :manage_vehicles, :leave], Trip do |trip|
        trip.participants.include?(person) ||
        trip.organizers.include?(person)
      end

      # Can Manage Trip
      can [:edit, :update, :destroy, :invite], Trip do |trip|
        trip.organizers.include?(person)
      end

      # Can View Trip Arrangements
      can [:index], Arrangement do |arrangement|
        arrangement.trip.participants.include?(person) ||
        arrangement.trip.organizers.include?(person)
      end

      # Can Manage Trip Arrangements
      can [:generate], Arrangement do |arrangement|
        arrangement.trip.organizers.include?(person)
      end
    end
  end
end