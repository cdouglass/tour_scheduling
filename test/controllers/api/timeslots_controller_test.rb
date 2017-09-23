require 'test_helper'

class Api::TimeslotsControllerTest < ActionDispatch::IntegrationTest
  def test_gets_index
     get api_timeslots_url
     assert_response :success

     expected_response = "[{\"id\":298486374,\"start_time\":1406052000,\"duration\":1},{\"id\":980190962,\"start_time\":1506520000,\"duration\":5}]"
     assert_equal(response.body, expected_response)
   end

   def test_create
     assert_difference('Timeslot.count', 1) do
       post api_timeslots_url, params: {timeslot: {start_time: "1406052000", duration: "120"}}
       assert_response :success
       expected_response = "{\"id\":980190963,\"start_time\":1406052000,\"duration\":120}"
       assert_equal(response.body, expected_response)
     end
   end
end
