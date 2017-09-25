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
end
