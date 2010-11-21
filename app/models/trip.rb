class Trip < ActiveRecord::Base
  validates :name, :presence => true
  validates :time, :presence => true, :timeliness => {:type => :datetime}
  validates :address, :mailing_address => true
  validates :organizer, :existence => {:allow_nil => false}

  has_many :arrangements
  belongs_to :organizer, :class_name => "Person", :foreign_key => "organizer_id"
  has_and_belongs_to_many :participants, :class_name => "Person",
    :join_table => "participants_trips", :association_foreign_key => "participant_id"
  has_and_belongs_to_many :invitees, :class_name => "Person",
    :join_table => "invitees_trips", :association_foreign_key => "invitee_id"
  has_and_belongs_to_many :vehicles
  
  def arrangement_for(person)
    return self.arrangements.select { |arrangement| self.arrangement.passengers.include?(person) }.first
  end

  def organized_by?(person)
    return self.organizer == person
  end

  def upcoming?
    return self.time >= Time.now()
  end
  
  def generate_arrangements
    if self.vehicles.length != 0
      vehicles = self.vehicles
      vehicles_capacity = vehicles.map{|v| v.capacity}
      drivers = vehicles.map {|v| v.owner}
      drivers_index = (0..drivers.length-1).entries
      passengers = self.participants - drivers
      passengers_index = (drivers.length..drivers.length+passengers.length-1).entries
      addresses = (drivers + passengers).map{|p| p.address} + [self.address]
      destination = addresses.length-1
      distances = Trip.distance_matrix(addresses)
      
      # Iterate through each driver now
      
      for driver in drivers_index
        driver_arrangement = Arrangement.new(:driver => drivers[driver], :vehicle => vehicles[driver])
        if passengers_index.length > 0
          driver_passengers = Trip.anneal_passengers(driver, passengers_index, destination, distances, vehicles_capacity[driver])
          for passenger in driver_passengers
            driver_arrangement.passengers << passengers[passenger-drivers.length]
          end
          passengers_index = passengers_index - driver_passengers
        end
        self.arrangements << driver_arrangement
      end
      self.save
    end
  end

  # Below are private methods used for generate_arrangements  
  private
  
  # anneal_passengers utilizes simulated annealing to determine an optimal subset of passengers for one vehicle
  def self.anneal_passengers(driver, passengers, destination, distances, capacity)
    # Check to see if there are less passengers than capacity
    if passengers.length < capacity
      # If it is, then we simply return the best path
      capacity = passengers.length+1
      best_path, best_score = Trip.anneal_path(driver, passengers, destination, distances, Math.exp(capacity).ceil)
    else
      # Otherwise, anneal to find an optimal set of passengers
      current_passengers = passengers.combination(capacity-1).first
      current_path, current_score = Trip.anneal_path(driver, current_passengers, destination, distances, Math.exp(capacity).ceil)
      best_path, best_score = Array.new(current_path), current_score
      # Keep track of number of evaluations and stop when it reachs a limit
      max_evaluations = Math.exp(passengers.length).ceil
      num_evaluations = 1
      # Anneal through a schedule as follows
      Trip.anneal_schedule(10, 0.9999) { |temp|
        done = false
        Trip.all_combinations(passengers, current_passengers, capacity) { |new_passengers|
          # Check to see if we hit the maximum amount of evaluations
          if num_evaluations >= max_evaluations
            done = true
            break
          end
          num_evaluations += 1
          # Otherwise, anneal a new path from the new combination of passengers
          new_path, new_score = Trip.anneal_path(driver, new_passengers, destination, distances, Math.exp(capacity).ceil)
          # Determine the probability of choosing this new_path
          new_prob = Trip.anneal_probability(current_score, new_score, temp)
          # Save the best path and score
          if best_score > new_score
            best_path, best_score = Array.new(new_path), new_score
          end
          if rand < new_prob
            current_passengers, current_path, current_score = new_passengers, new_path, new_score
            break
          end
        }
        if done
          break
        end
      }
    end
    return best_path[1..capacity-1]
  end
  
  # all_combinations is a helper for anneal_passengers
  def self.all_combinations(passengers, current_combination, capacity)
    # Yield combinations in a random order
    passenger_combinations = passengers.combination(capacity-1).to_a.shuffle
    for passenger_combination in passenger_combinations
      if passenger_combination != current_combination
        yield passenger_combination
      end
    end
  end
  
  def self.anneal_path(driver, passengers, destination, distances, max_evaluations)
    # Check to see if there's only one passenger
    if passengers.length <= 1
      # If so, return the only route possible
      best_path = [driver] + passengers + [destination]
      best_score = Trip.path_score(best_path, distances)
    else
      # Otherwise, anneal to find the an optimal path
      current_path = [driver] + passengers.shuffle + [destination]
      current_score = Trip.path_score(current_path, distances)
      best_path, best_score = Array.new(current_path), current_score
      # Keep track of number of evaluations
      num_evaluations = 1
      # Anneal through a schedule as follows
      Trip.anneal_schedule(10, 0.9999) { |temp|
        Trip.all_permutations(passengers, current_path[1..current_path.length-2]) { |new_path|
          # Check to see if we hit maximum evaluations
          if num_evaluations >= max_evaluations
            done = true
            break
          end
          # Otherwise, generate a new path
          num_evaluations += 1
          new_path = [driver] + new_path + [destination]
          new_score = Trip.path_score(new_path, distances)
          # Determine the probability of this new path
          new_prob = Trip.anneal_probability(current_score, new_score, temp)
           # Save the best path and score
          if best_score > new_score
            best_path, best_score = Array.new(new_path), new_score
          end
          if rand < new_prob
            current_path, current_score = new_path, new_score
            break
          end
        }
        if done
          break
        end
      }
    end
    return [best_path, best_score]
  end
  
  # all_permutations is a helper for anneal_passengers
  def self.all_permutations(passengers, current_permutation)
    # Yield permutations in random order
    passenger_permutations = passengers.permutation(passengers.length).to_a.shuffle
    for passenger_permutation in passenger_permutations
      if passenger_permutation != current_permutation
        yield passenger_permutation
      end
    end
  end

  # path_score returns the score (i.e. distance) of a path
  def self.path_score(path, distances)
    # Returns the total distance of a given path
    total_distance = 0
    num_points = path.length
    0.upto(num_points-2) { |index|
      total_distance += distances[[path[index], path[index+1]]]
    }
    return total_distance
  end

  # anneal_schedule is a helper method for both anneal_passengers and anneal_path
  def self.anneal_schedule(temp, alpha)
    # Yield a schedule for annealing
    while true
      yield temp
      temp = alpha*temp
    end
  end
  
  # anneal_probability is a helper method for both anneal_passengers and anneal_path
  def self.anneal_probability(previous, current, temperature)
    # Returns a probability
    if current > previous
      return 1.0
    else
      return Math.exp(-((current-previous).abs)/temperature)
    end
  end
  
  def self.distance_matrix(address_list)
    # Returns a distance matrix between all addresses
    distances = Hash.new
    address_list.each_with_index { |address_1, index_1|
      address_list.each_with_index { |address_2, index_2|
        if distances.has_key?([index_2, index_1])
          distances[[index_1, index_2]] = distances[[index_2, index_1]]
        else
          address_1_coord, address_2_coord = Geocoder.fetch_coordinates(address_1), Geocoder.fetch_coordinates(address_2)
          distances[[index_1, index_2]] = Geocoder.distance_between(address_1_coord[0], address_1_coord[1], address_2_coord[0], address_2_coord[1])
        end
      }
    }
    return distances
  end
end
