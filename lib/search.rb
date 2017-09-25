# mimic SearchObject to get a feel for what they share and whether it makes sense for both to be subclasses of a thing, or what
class SearchAvailability
  def initialize(boat_sizes, booking_sizes)
    @boats = boat_sizes.sort
    @bookings = booking_sizes
    @boat_index = nil
  end

  def accept?
    @bookings.empty?
  end

  # inefficient - combine with make_next_move?
  def can_move?
    return false if @bookings.empty?
    size = @bookings[-1]
    i = (@boat_index || -1) + 1
    @boats.slice(i..-1).any? {|capacity| capacity >= size }
  end

  def make_next_move
    size = @bookings.pop
    last = (@boat_index || -1) + 1
    i = @boats.slice(last..-1).find_index { |capacity| capacity >= size } + last
    @boats[i] -= size
    @boat_index = 0
    { boat: i, booking: size }
  end

  def backtrack(stack)
    i = stack[-1][:boat]
    size = stack[-1][:booking]
    @bookings.push(size)
    @boats[i] += size
    @boat_index = i
  end
end

# Test example
# Given an array of integers and a target, find subsequences which sum to the target
class SearchObject
  def initialize(target, array)
    @target = target
    @array = array
    @current_sum = 0
    @current_index = nil
    @last_tried = nil
  end

  def accept?
    @target == @current_sum
  end

  def can_move?
    if @array.empty?
      false
    elsif @last_tried.nil?
        @current_index.nil? || (@current_index < @array.length - 1)
    else
      (@last_tried < @array.length - 1)
    end
  end

  def make_next_move
    if @last_tried.nil?
      @current_index = (@current_index || -1) + 1
    else
      @current_index = @last_tried + 1
    end
    @last_tried = @current_index
    @current_sum += @array[@current_index]
    @current_index
  end

  def backtrack(stack)
    @current_sum -= @array[stack[-1]]
    @last_tried = stack[-1] # we know this isn't nil
    @current_index = stack[-2]
  end
end

# Returns array of all solutions
def depth_first_search(search_object)
  stack = []
  solutions = []

  loop do
    if search_object.accept?
      solutions.push(Array.new(stack)) # copy
      search_object.backtrack(stack)
      stack.pop
    elsif search_object.can_move?
      move = search_object.make_next_move
      stack.push(move)
    elsif stack.empty?
      break
    else
      search_object.backtrack(stack)
      stack.pop
    end
  end

  solutions
end
