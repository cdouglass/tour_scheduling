require 'test_helper'

class Api::TimeslotsControllerTest < ActionDispatch::IntegrationTest
  def test_index_defaults_to_today
    Timecop.travel("2014-07-22".to_time.midnight) do
      get api_timeslots_url
      assert_response :success

      expected_response = "[{\"id\":3,\"start_time\":1406012400,\"duration\":1},{\"id\":2,\"start_time\":1406052000,\"duration\":1}]"
      assert_equal(response.body, expected_response)
    end
  end

  def test_filters_by_date
    days = [
      ["2014-07-21", "[{\"id\":5,\"start_time\":1406012399,\"duration\":0}]"],
      ["2014-07-22", "[{\"id\":3,\"start_time\":1406012400,\"duration\":1},{\"id\":2,\"start_time\":1406052000,\"duration\":1}]"],
      ["2014-07-23", "[{\"id\":4,\"start_time\":1406098800,\"duration\":1}]"]
    ]

    days.each do |date, expected_response|
      get api_timeslots_url, params: {date: date}
      assert_equal(response.body, expected_response)
    end
  end

  def test_create
    assert_difference('Timeslot.count', 1) do
      post api_timeslots_url, params: {timeslot: {start_time: "1406052000", duration: "120"}}
      assert_response :success
      expected_response = "{\"id\":6,\"start_time\":1406052000,\"duration\":120}"
      assert_equal(response.body, expected_response)
    end
  end
end
