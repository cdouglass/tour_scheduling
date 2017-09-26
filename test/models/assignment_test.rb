require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  def setup
    @assignment = Assignment.new(boat: boats(:nonsense), timeslot: timeslots(:one))
  end

  def test_valid
    assert @assignment.valid?
  end

  def test_boat_must_exist
    [nil, 999, "foo"].each do |val|
      @assignment.boat_id = val
      assert @assignment.invalid?
    end
  end

  def test_timeslot_must_exist
    [nil, 999, "foo"].each do |val|
      @assignment.timeslot_id = val
      assert @assignment.invalid?
    end
  end

  def test_no_overlaps
    @assignment.save!
    # existing assignment already confirmed by booking fixture :one
    overlapping = [:extends_into_day_1, :before_and_after_day_one]
    overlapping.each do |name|
      a = Assignment.new(boat: boats(:nonsense), timeslot: timeslots(name))
      assert a.invalid?
    end

    Booking.last.delete

    overlapping.each do |name|
      a = Assignment.new(boat: boats(:nonsense), timeslot: timeslots(name))
      assert a.valid?
    end
  end

  def test_adjoining_timeslots
    @assignment.timeslot = timeslots(:just_before_two)
    @assignment.save!
    Booking.create!(size: 1, timeslot: timeslots(:just_before_two))
    a = Assignment.new(boat: boats(:nonsense), timeslot: timeslots(:midnight_of_two))
    assert a.valid?
  end
end
