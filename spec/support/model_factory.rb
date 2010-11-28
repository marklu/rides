
require 'digest/md5'

module ModelFactory
  def random_string(length)
    chars = [('A'..'Z'), ('a'..'z'), ('0'..'9')].inject([]) {|arr, ran| arr + ran.to_a}
    (0...length).inject('') {|str, i| str + chars[Kernel.rand(chars.size)]}
  end

  def valid_attributes_for(model)
    case model
    when 'Person'
      return {
        :email => "#{random_string(10)}@#{random_string(10)}.com",
        :password => 'testpassword123',
        :password_confirmation => 'testpassword123',
        :name => 'First Last',
        :phone => '123-456-7890',
        :location => Location.create!(:location => '1600 Amphitheatre Parkway, Mountain View, CA'),
        :music => 'no_preference',
        :smoking => 'no_preference'
      }
    when 'Trip'
      return {
        :name => 'Trip Name',
        :time => Time.now,
        :location => Location.create!(:location => '1 Infinite Loop, Cupertino, CA'),
        :organizer => create_valid!('Person')
      }
    when 'Vehicle'
      return {
        :make => 'Make',
        :model => 'Model',
        :capacity => 4,
        :owner => create_valid!('Person')
      }
    when 'Invitation'
      email = "#{random_string(10)}@#{random_string(10)}.com"
      return {
        :email => email,
        :token => Digest::MD5.hexdigest(email+@trip.id.to_s)
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