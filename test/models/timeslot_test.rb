require 'test_helper'

class TimeslotTest < ActiveSupport::TestCase

  def setup
    @timeslot = Timeslot.new(start_time: 1_000_000, duration: 20)
  end

  def test_valid_timeslot
    assert @timeslot.valid?
  end

  def test_validates_start_time_is_integer
    [10.5, "foo", nil].each do |val|
      @timeslot.start_time = val
      assert @timeslot.invalid?
    end
  end

  def test_validates_duration_is_positive_integer
    [10.5, "foo", nil, -10].each do |val|
      @timeslot.duration = val
      assert @timeslot.invalid?
    end
  end

  def test_duration
    assert_equal(20, @timeslot.duration)
  end

  def test_availability
    assert_equal(999_989, timeslots(:one).availability)
  end

  def test_customer_count
    assert_equal(11, timeslots(:one).customer_count)
  end

  # boat is assi
  def test_availability_with_conflicting_assignments
    t1 = Timeslot.create(start_time: 1_000_000, duration: 20)
    t2 = Timeslot.create(start_time: 1_000_000, duration: 20)

    Assignment.create(boat: boats(:rtfm), timeslot: t1)
    Assignment.create(boat: boats(:rtfm), timeslot: t2)
    Assignment.create(boat: boats(:nonsense), timeslot: t2)

    assert_equal(40, t1.availability)
    assert_equal(40, t2.availability)

    booking = Booking.create(size: 20, timeslot: t1)

    assert_equal(20, t1.availability)
    assert_equal(15, t2.availability)

    booking.size = 10
    booking.timeslot = t2
    booking.save

    t1.bookings.delete_all
    assert_equal(40, t2.availability)
    assert_equal(0, t1.reload.availability)
  end
end
