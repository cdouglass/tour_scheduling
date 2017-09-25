require 'test_helper'

class Api::AssignmentsControllerTest < ActionDispatch::IntegrationTest
  def create_request(timeslot_id, boat_id)
    post api_assignments_url, params: {assignment: {timeslot_id: timeslot_id, boat_id: boat_id}}
  end

  def test_create
    assert_difference('Assignment.count', 1) do
      timeslot = timeslots(:one)
      boat = boats(:rtfm)

      create_request(timeslot.id, boat.id)
      assert_response :created
    end
  end

  def test_create_with_invalid_association
    assert_difference('Assignment.count', 0) do
      timeslot = timeslots(:one)
      create_request(timeslot.id, 999)
      assert_response :not_found

      boat = boats(:rtfm)
      create_request(999, boat.id)
      assert_response :not_found
    end
  end

  def test_create_with_unavailable_boat
    assert_difference('Assignment.count', 0) do
      timeslot = timeslots(:before_and_after_day_one)
      boat = boats(:just_testing)

      create_request(timeslot.id, boat.id)
      assert_response :unprocessable_entity
    end
  end
end
