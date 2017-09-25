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
