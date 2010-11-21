module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /the home\s?page/ then root_path
    when /the sign in page/ then new_person_session_path
    when /the sign up page/ then new_person_registration_path
    when /the dashboard page/ then person_root_path
    when /the profile page/ then edit_person_registration_path
    when /the add vehicle page/ then new_vehicle_path
    when /the plan trip page/ then new_trip_path
    when /the trip history page/ then trips_path
    when /the trip info page/ then trip_path(@trip)
    when /the all arrangements page/ then trip_arrangements_path(@trip)
    when /the trip participants page/ then participants_trip_path(@trip)
    when /the invite user page/ then 
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
