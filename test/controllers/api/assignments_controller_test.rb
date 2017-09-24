require 'test_helper'

class Api::AssignmentsControllerTest < ActionDispatch::IntegrationTest
  def test_create
    assert_difference('Assignment.count', 1) do
      post api_assignments_url, params: {assignment: {timeslot_id: 1, boat_id: 2}}
      assert_response :created
    end
  end

  def test_create_with_invalid_association
    assert_difference('Assignment.count', 0) do
      post api_assignments_url, params: {assignment: {timeslot_id: 1, boat_id: 999}}
      assert_response :not_found

      post api_assignments_url, params: {assignment: {timeslot_id: 999, boat_id: 2}}
      assert_response :not_found
    end
  end

  def test_create_with_unavailable_boat
    assert_difference('Assignment.count', 0) do
      post api_assignments_url, params: {assignment: {timeslot_id: 7, boat_id: 3}}
      assert_response :unprocessable_entity
    end
  end
end
