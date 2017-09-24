require 'test_helper'

class Api::AssignmentsControllerTest < ActionDispatch::IntegrationTest
  def test_create
    assert_difference('Assignment.count', 1) do
      post api_assignments_url, params: {assignment: {timeslot_id: 1, boat_id: 2}}
      assert_response :created
    end
  end
end
