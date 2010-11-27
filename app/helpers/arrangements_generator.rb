module ArrangementsGenerator
  # Instance variables below used for caching combinations and permutations
  @passenger_combinations = []
  @path_permutations = []
  
  def self.generate_arrangements(arrangements, passengers)
    if not arrangements.empty? and not passengers.empty?
      distances = ArrangementsGenerator.generate_distance_matrix(arrangements, passengers)
      arrangements.each_with_index do |arrangement, index|
        arrangements[index], passengers = ArrangementsGenerator.generate_arrangement(arrangement, passengers, distances)
      end
    end
    return arrangements
  end
  
  def self.generate_arrangement(current_arrangement, remaining_passengers, distances)
    # OUTPUT: Updated Arrangement and Updated list of remaining passengers
    if not current_arrangement.full? and not remaining_passengers.empty?
      best_path = []
      best_path_score = 0
      if (remaining_passengers.length + current_arrangement.passengers.length) <= current_arrangement.capacity
        best_path, best_path_score = ArrangementsGenerator.generate_path(current_arrangement, remaining_passengers, distances)
      else
        @passenger_combinations = remaining_passengers.combination(current_arrangement.capacity-current_arrangement.passengers.length).to_a
        current_combination = @passenger_combinations[0]
        current_path, current_path_score = ArrangementsGenerator.generate_path(current_arrangement, current_combination, distances)
        best_path, best_path_score = Array.new(current_path), current_path_score
        num_evaluations = 1
        max_evaluations = Math.exp(remaining_passengers.length).ceil
        ArrangementsGenerator.annealing_schedule(10, 0.9999) do |temperature|
          done = false
          ArrangementsGenerator.random_passenger_combinations(current_combination) do |new_combination|
            if num_evaluations >= max_evaluations
              done = true
              break
            end
            num_evaluations += 1
            new_path, new_path_score = ArrangementsGenerator.generate_path(current_arrangement, new_combination, distances)
            if best_path_score > new_path_score
              best_path = Array.new(new_path)
              best_path_score = new_path_score
            end
            if rand < ArrangementsGenerator.annealing_probability(current_path_score, new_path_score, temperature)
              current_combination, current_path, current_path_score = new_combination, new_path, new_path_score
              break
            end
          end
          if done
            break
          end
        end
      end
      current_arrangement.passengers.clear
      best_path.each {|p| current_arrangement.passengers << p}
      remaining_passengers = remaining_passengers - best_path
    end
    return [current_arrangement, remaining_passengers]
  end
  
  # Helper methods for generate_arrangement
  def self.random_passenger_combinations(assigned_passengers)
    # Returns all combinations of the array specified in @passenger_combinations
    random_passengers = @passenger_combinations.shuffle
    for passenger in random_passengers
      if passenger != assigned_passengers
        yield passenger
      end
    end
  end
  
  def self.generate_path(current_arrangement, assigned_passengers, distances)
    # OUTPUT: 'Path' of passengers to go through; consists of passengers in current_arrangement and in assigned_passengers
    path_origin = [current_arrangement]
    path_destination = [current_arrangement.destination]
    path = current_arrangement.passengers
    path_score = ArrangementsGenerator.score_path(path_origin + path + path_destination, distances)
    if not current_arrangement.full? and not ((path.length + assigned_passengers.length) > current_arrangement.capacity) and not assigned_passengers.empty?
      if path.empty? and (assigned_passengers.length == 1)
        path = assigned_passengers
        path_score = ArrangementsGenerator.score_path(path_origin + path + path_destination, distances)
      else
        @path_permutations = (path + assigned_passengers).permutation(path.length + assigned_passengers.length).to_a
        path = @path_permutations[0]
        path_score = ArrangementsGenerator.score_path(path_origin + path + path_destination, distances)
        best_path = Array.new(path)
        best_score = path_score
        num_evaluations = 1
        max_evaluations = Math.exp(path.length + assigned_passengers.length).ceil
        ArrangementsGenerator.annealing_schedule(10, 0.9999) do |temperature|
          done = false
          ArrangementsGenerator.random_path_permutations(path) do |new_path|
            if num_evaluations >= max_evaluations
              done = true
              break
            end
            num_evaluations += 1
            new_score = ArrangementsGenerator.score_path(path_origin + new_path + path_destination, distances)
            if best_score > new_score
              best_path = Array.new(new_path)
              best_score = new_score
            end
            if rand < ArrangementsGenerator.annealing_probability(path_score, new_score, temperature)
              path, path_score = new_path, new_score
              break
            end
          end
          if done
            break
          end
        end
        path = best_path
        path_score = best_score
        @path_permutations = []
      end
    end
    return [path, path_score]
  end
  
  # Helper methods for generate_path below
  def self.random_path_permutations(current_path)
    # Returns all permutations of the array specified in @path_permutations
    random_paths = @path_permutations.shuffle
    for path in random_paths
      if path != current_path
        yield path
      end
    end
  end
  
  # Helper methods for generate_path and generate_arrangement
  def self.annealing_schedule(temperature, alpha)
    # Yields a temperature schedule for simulated annealing
    while true
      yield temperature
      temperature = alpha*temperature
    end
  end
  
  def self.annealing_probability(current_score, new_score, temperature)
    # Returns the chance that current solution is chosen over new solution
    if new_score < current_score
      return 1.0
    else
      return Math.exp(-((current_score-new_score).abs)/temperature)
    end
  end
  
  def self.generate_distance_matrix(arrangements, passengers)
    distances = Hash.new
    if not arrangements.empty? and not passengers.empty?
      arrangements.each do |arrangement|
        total_passengers = arrangement.passengers + passengers
        total_passengers.permutation(2).each do |key|
          if distances.has_key?([key[1], key[0]])
            distances[key] = distances[[key[1], key[0]]]
          else
            distances[key] = key[0].location.distance_to(key[1].location)
          end
        end
        
        total_passengers.each do |passenger|
          distances[[arrangement, passenger]] = arrangement.origin.distance_to(passenger.location)
          distances[[passenger, arrangement]] = distances[[arrangement, passenger]]
          distances[[arrangement.destination, passenger]] = arrangement.destination.distance_to(passenger.location)
          distances[[passenger, arrangement.destination]] = distances[[arrangement.destination, passenger]]
        end
        
        distances[[arrangement, arrangement.destination]] = arrangement.origin.distance_to(arrangement.destination)
        distances[[arrangement.destination, arrangement]] = distances[[arrangement, arrangement.destination]]
      end
    end
    return distances
  end

  def self.score_path(path, distances)
    path_score = 0.0
    if not (path.length <= 1) and not distances.empty?
      0.upto(path.length-2) do |index|
        path_score += distances[[path[index], path[index+1]]]
      end
    end
    return path_score
  end
end