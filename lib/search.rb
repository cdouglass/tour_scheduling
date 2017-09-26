class Search
  def initialize(all_moves)
    @all_moves = all_moves
  end

  def accept?
    false
  end

  def backtrack
  end

  def can_move
    false
  end

  def quality(solution)
    0
  end

  def make_next_move
  end

  # Returns array of all solutions
  def depth_first_search
    stack = []
    best = nil

    loop do
      if accept?
        q = quality(stack)
        if best.nil? || (q > best[:quality])
          best = {quality: quality(stack), solution: Array.new(stack)}
        end
        backtrack(stack)
        stack.pop
      elsif can_move?
        move = make_next_move
        stack.push(move)
      elsif stack.empty?
        break
      else
        backtrack(stack)
        stack.pop
      end
    end

    best
  end
end


# mimic SearchObject to get a feel for what they share and whether it makes sense for both to be subclasses of a thing, or what
# Assume WLOG we have a unique way of indexing into set of all possible moves
class SearchAvailability < Search
  def initialize(boat_sizes, booking_sizes)
    super(boat_sizes)
    @all_moves.sort
    @bookings = booking_sizes
    @boat_index = nil
  end

  def accept?
    @bookings.empty?
  end

  def quality(_)
    @all_moves.max
  end

  # inefficient - combine with make_next_move?
  def can_move?
    return false if @bookings.empty?
    size = @bookings[-1]
    i = (@boat_index || -1) + 1
    @all_moves.slice(i..-1).any? {|capacity| capacity >= size }
  end

  def make_next_move
    size = @bookings.pop
    last = (@boat_index || -1) + 1
    i = @all_moves.slice(last..-1).find_index { |capacity| capacity >= size } + last
    @all_moves[i] -= size
    @boat_index = 0
    { index: i, booking: size }
  end

  def backtrack(stack)
    i = stack[-1][:index]
    size = stack[-1][:booking]
    @bookings.push(size)
    @all_moves[i] += size
    @boat_index = i
  end
end

# Test example
# Given an array of integers and a target, find subsequences which sum to the target
class SearchObjectExample < Search
  def initialize(target, array)
    super(array)
    @target = target
    @current_sum = 0
    @current_index = nil
    @last_tried = nil
  end

  def accept?
    @target == @current_sum
  end

  def can_move?
    if @all_moves.empty?
      false
    elsif @last_tried.nil?
        @current_index.nil? || (@current_index < @all_moves.length - 1)
    else
      (@last_tried < @all_moves.length - 1)
    end
  end

  def make_next_move
    if @last_tried.nil?
      @current_index = (@current_index || -1) + 1
    else
      @current_index = @last_tried + 1
    end
    @last_tried = @current_index
    @current_sum += @all_moves[@current_index]
    { index: @current_index }
  end

  def backtrack(stack)
    i = stack[-1][:index]
    @current_sum -= @all_moves[i]
    @last_tried = i
    @current_index = stack[-2]
  end
end
