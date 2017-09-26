require 'search'
require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  def test_search
    array = [1, 5, 2, 3, 4, 6, -1]
    target = 5
    expected = { quality: 0, solution: [{ index: 0}, { index: 1}, { index: 6}] }
    obj = SearchObjectExample.new(target, array)
    assert_equal(expected, obj.depth_first_search)
  end

  def test_distributing_bookings
    boat_sizes = [1, 3, 5]
    booking_sizes = [3, 2, 1]
    expected = { quality: 3, solution: [{ index: 0, booking: 1 }, { index: 2, booking: 2 }, { index: 1, booking: 3 }] }

    obj = SearchAvailability.new(boat_sizes, booking_sizes)
    assert_equal(expected, obj.depth_first_search)
  end
end

