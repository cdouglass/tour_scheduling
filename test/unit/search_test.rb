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
    obj = SearchObjectExample.new(target, array)
    solutions = obj.depth_first_search
    assert_equal(expected_solutions, solutions.map {|x| x.map {|y| y[:index]}})
  end

  def test_distributing_bookings
    boat_sizes = [1, 3, 5]
    booking_sizes = [3, 2, 1]
    expected_solutions = [
      [{:index=>0, :booking=>1}, {:index=>1, :booking=>2}, {:index=>2, :booking=>3}],
      [{:index=>0, :booking=>1}, {:index=>2, :booking=>2}, {:index=>1, :booking=>3}],
      [{:index=>0, :booking=>1}, {:index=>2, :booking=>2}, {:index=>2, :booking=>3}],
      [{:index=>1, :booking=>1}, {:index=>1, :booking=>2}, {:index=>2, :booking=>3}],
      [{:index=>1, :booking=>1}, {:index=>2, :booking=>2}, {:index=>2, :booking=>3}],
      [{:index=>2, :booking=>1}, {:index=>1, :booking=>2}, {:index=>2, :booking=>3}],
      [{:index=>2, :booking=>1}, {:index=>2, :booking=>2}, {:index=>1, :booking=>3}]
    ]

    obj = SearchAvailability.new(boat_sizes, booking_sizes)
    solutions = obj.depth_first_search
    assert_equal(expected_solutions, solutions)
  end
end

