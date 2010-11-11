module ModelFactory
  def valid_attributes_for(model)
    case model
    when "Person"
      return {
        :email => 'email@email.com',
        :password => 'testpassword123',
        :password_confirmation => 'testpassword123',
        :name => 'First Last',
        :phone => '123-456-7890',
        :address => '123 Address',
        :city => 'City',
        :state => 'State',
        :music => 'no_preference',
        :smoking => 'no_preference'
      }
    when "Trip"
      return {
        :name => "Trip Name",
        :time => Time.now,
        :address => "1234 Address",
        :city => "City",
        :state => "State",
        :organizer => create_valid("Person")
      }
    when "Vehicle"
      return {
        :make => "Make",
        :model => "Model",
        :capacity => 4,
        :owner => create_valid("Person")
      }
    else
      raise "Unrecognized Model: #{model}"
    end
  end

  def create_valid(model, params = {})
    model.constantize.create(valid_attributes_for(model).merge(params))    
  end

  def create_valid!(model, params = {})
    model.constantize.create!(valid_attributes_for(model).merge(params))    
  end
end