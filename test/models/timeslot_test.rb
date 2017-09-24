require 'test_helper'

class TimeslotTest < ActiveSupport::TestCase

  def setup
    @timeslot = Timeslot.new(start_time: 1_000_000, end_time: 2_000_000)
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

  def test_validates_end_time_is_integer
    [10.5, "foo", nil].each do |val|
      @timeslot.end_time = val
      assert @timeslot.invalid?
    end
  end

  def test_validates_end_after_start
    @timeslot.end_time = @timeslot.start_time
    assert @timeslot.invalid?

    @timeslot.end_time = @timeslot.start_time - 1_000
    assert @timeslot.invalid?
  end
end
