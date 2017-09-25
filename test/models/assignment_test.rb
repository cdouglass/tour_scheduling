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
    [:extends_into_day_1, :before_and_after_day_one].each do |name|
      a = Assignment.new(boat: boats(:nonsense), timeslot: timeslots(name))
      assert a.invalid?
    end

    @assignment.timeslot = timeslots(:midnight_of_two)
    @assignment.save!
    [:midnight_of_two].each do |name|
      a = Assignment.new(boat: boats(:nonsense), timeslot_id: name)
      assert a.invalid?
    end
  end

  def test_adjoining_timeslots
    @assignment.timeslot = timeslots(:just_before_two)
    @assignment.save!
    a = Assignment.new(boat: boats(:nonsense), timeslot: timeslots(:midnight_of_two))
    assert a.valid?
  end
end
