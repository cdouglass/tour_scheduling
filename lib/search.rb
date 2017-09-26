class Search
  def initialize(all_moves)
    @all_moves = all_moves
    @last_index_tried = nil
  end

  def one_after_last
    @last_index_tried.nil? ? 0 : @last_index_tried + 1
  end

  def accept?
    false
  end

  def quality(solution)
    0
  end

  def make_next_move
    if one_after_last < @all_moves.length
      @last_index_tried = one_after_last
      { index: @last_index_tried }
    end
  end

  def backtrack(stack)
    item = stack.pop
    @last_index_tried = item[:index]
    item
  end

  def depth_first_search
    stack = []
    best_so_far = nil

    loop do
      if accept?
        q = quality(stack)
        if best_so_far.nil? || (q > best_so_far[:quality])
          best_so_far = {quality: q, solution: Array.new(stack)}
        end
      else
        move = make_next_move
        if !move.nil?
          stack.push(move)
          next
        elsif stack.empty?
          break
        end
      end
      backtrack(stack)
    end

    best_so_far
  end
end

class SearchAvailability < Search
  def initialize(boat_sizes, booking_sizes)
    super(boat_sizes)
    @all_moves.sort
    @bookings = booking_sizes
  end

  def accept?
    @bookings.empty?
  end

  def quality(_)
    @all_moves.max
  end

  def make_next_move
    move = super
    size = @bookings[-1]
    i = @all_moves.slice(@last_index_tried..-1).find_index { |capacity| capacity >= size }
    return nil if move.nil? || i.nil?
    @bookings.pop
    @all_moves[@last_index_tried + i] -= size
    @last_index_tried = 0
    move[:index] += i
    move[:booking] = size
    move
  end

  # return item, for consistency
  def backtrack(stack)
    item = super(stack)
    size = item[:booking]
    @bookings.push(size)
    @all_moves[@last_index_tried] += size
    item
  end
end

# Given an array of integers and a target, find subsequences which sum to the target
class SearchObjectExample < Search
  def initialize(target, array)
    super(array)
    @target = target
    @sum = 0
  end

  def accept?
    @target == @sum
  end

  def make_next_move
    move = super
    @sum += @all_moves[@last_index_tried] if !move.nil?
    move
  end

  def backtrack(stack)
    item = super(stack)
    @sum -= @all_moves[@last_index_tried]
    item
  end
end
