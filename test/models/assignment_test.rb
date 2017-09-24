require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  def setup
    @assignment = Assignment.new(boat_id: 1, timeslot_id: 1)
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
    [6, 7].each do |id|
      a = Assignment.new(boat_id: 1, timeslot_id: id)
      assert a.invalid?
    end

    @assignment.timeslot_id = 3
    @assignment.save!
    [3].each do |id|
      a = Assignment.new(boat_id: 1, timeslot_id: id)
      assert a.invalid?
    end
  end

  def test_adjoining_timeslots
    @assignment.timeslot_id = 5
    @assignment.save!
    a = Assignment.new(boat_id: 1, timeslot_id: 3)
    assert a.valid?
  end
end
