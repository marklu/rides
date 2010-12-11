module ModelFactory
  def valid_attributes_for(model)
    case model.to_s
    when 'Arrangement'
      return {
        :destination => create_valid!(Location),
        :origin => create_valid!(Location),
        :trip => create_valid!(Trip),
        :vehicle => create_valid!(Vehicle)
      }
    when 'Invitation'
      return {
        :invitee => 'Invitee Name',
        :email => "#{random_string(10)}@email.com",
        :role => 'participant',
        :inviter => 'Inviter Name',
        :token => random_string(10),
        :trip => create_valid!(Trip)
      }
    when 'Location'
      return {
        :location => '1600 Amphitheatre Parkway, Mountain View, CA',
        :latitude => 37.422782,
        :longitude => -122.085099
      }
    when 'Person'
      return {
        :email => "#{random_string(10)}@email.com",
        :password => 'testpassword123',
        :password_confirmation => 'testpassword123',
        :name => 'First Last',
        :phone => '123-456-7890',
        :location => create_valid!(Location),
        :music => 'no_preference',
        :smoking => 'no_preference'
      }
    when 'Trip'
      return {
        :name => 'Trip Name',
        :time => Time.now,
        :location => create_valid!(Location),
        :organizers => [create_valid!(Person)]
      }
    when 'Vehicle'
      return {
        :make => 'Make',
        :model => 'Model',
        :capacity => 4,
        :owner => create_valid!(Person)
      }
    else
      raise "Unrecognized Model: #{model.to_s}"
    end
  end

  def build_valid(model, params = {})
    model.new(valid_attributes_for(model).merge(params))    
  end

  def create_valid(model, params = {})
    model.create(valid_attributes_for(model).merge(params))    
  end

  def create_valid!(model, params = {})
    model.create!(valid_attributes_for(model).merge(params))    
  end

  def random_string(length)
    chars = [('A'..'Z'), ('a'..'z'), ('0'..'9')].inject([]) {|arr, ran| arr + ran.to_a}
    (0...length).inject('') {|str, i| str + chars[Kernel.rand(chars.size)]}
  end
end