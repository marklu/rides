class ApplicationController < ActionController::Base
  protect_from_forgery

  # CanCan Configuration
  def current_ability
    @current_ability ||= PersonAbility.new(current_person)
  end

  rescue_from CanCan::AccessDenied do |exception|
    trip = exception.subject.class == Trip ? exception.subject :
           exception.subject.class == Arrangement ? exception.subject.trip :
           nil

    if trip.nil?
      redirect_to(person_root_url, :alert => exception.message)
    elsif trip.participants.include?(current_person) || trip.organizers.include?(current_person)
      redirect_to(trip, :alert => exception.message)
    else
      redirect_to(person_root_url, :alert => exception.message)
    end
  end
end
