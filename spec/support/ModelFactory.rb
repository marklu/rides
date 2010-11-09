module ModelFactory
  def attributes_for(model)
    case model
    when "Person"
      return {
        :email => 'email@email.com',
        :password => 'testpassword123',
        :password_confirmation => 'testpassword123',
        :name => 'John Test',
        :phone => '123-456-7890',
        :address => '123 Main St.',
        :city => 'Testville',
        :state => 'CA',
        :music => 'no_preference',
        :smoking => 'no_preference'
      }
    when "Trip"
      return {
        :name => "Some Trip",
        :time => Time.now,
        :address => "1234 Main St",
        :city => "Berkeley",
        :state => "CA",
        :organizer => make("Person")
      }
    when "Vehicle"
      return {
        :make => "Make",
        :model => "Model",
        :capacity => 4,
        :owner => make("Person")
      }
    else
      raise "Unrecognized Model: #{model}"
    end
  end

  def make(model, params = {})
    model.constantize.create(attributes_for(model).merge(params))    
  end

  def make!(model, params = {})
    model.constantize.create!(attributes_for(model).merge(params))    
  end
end