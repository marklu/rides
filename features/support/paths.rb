module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /the home\s?page/ then '/'
    when /the edit profile page/ then '/profile'
    when /the sign up page/ then '/signup'
    when /the sign in page/ then '/signin'
    when /the trips dashboard|the dashboard page/ then '/dashboard'
    when /the person registration page/ then '/signup'
    when /the create trip page/ then '/trips/new'
    when /the add vehicle page/ then '/vehicles/new'
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
