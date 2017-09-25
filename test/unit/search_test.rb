require 'search'
require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  def test_search
    array = [1, 5, 2, 3, 4, 6, -1]
    target = 5
    expected_solutions = [
      [0, 1, 6],
      [0, 2, 3, 6],
      [0, 4],
      [1],
      [2, 3],
      [2, 4, 6],
      [5, 6]
    ]
    obj = SearchObject.new(target, array)
    solutions = depth_first_search(obj)
    assert_equal(expected_solutions, solutions)
  end
end

