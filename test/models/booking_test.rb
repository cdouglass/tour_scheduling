require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  def setup
    @booking = Booking.new(size: 5, timeslot_id: 1)
  end

  def test_valid
    assert @booking.valid?
  end

  def test_timeslot_must_exist
    [nil, 999, "foo"].each do |val|
      @booking.timeslot_id = val
      assert @booking.invalid?
    end
  end

  def test_size_must_be_positive_integer
    [nil, 10.5, "foo", 0, -10].each do |val|
      @booking.size = val
      assert @booking.invalid?
    end
  end
end