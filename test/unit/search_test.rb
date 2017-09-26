require 'search'
require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  class SearchSpy < SearchAvailability
    def initialize(boat_sizes, booking_sizes)
      @count = 0
      super(boat_sizes, booking_sizes)
    end

    def accept?
      result = super
      @count += 1 if result
      result
    end

    def count
      @count
    end
  end

  def test_availability_search
    boat_sizes = [1, 3, 5]
    booking_sizes = [3, 2, 1]
    expected = { quality: 3, solution: [{ index: 0, booking: 1 }, { index: 2, booking: 2 }, { index: 1, booking: 3 }] }

    obj = SearchSpy.new(boat_sizes, booking_sizes)
    assert_equal(expected, obj.depth_first_search)
    # optimal solution is the second of the 7 it would check in exhaustive search
    assert_equal(2, obj.count)
  end
end

