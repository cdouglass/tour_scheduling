require 'test_helper'

class Api::TimeslotsControllerTest < ActionDispatch::IntegrationTest
  def test_index_defaults_to_today
    Timecop.travel("2014-07-22".to_time.midnight) do
      get api_timeslots_url
      assert_response :success

      expected_response = "[{\"id\":3,\"start_time\":1406012400,\"duration\":1,\"availability\":0,\"customer_count\":0,\"boats\":[]},{\"id\":2,\"start_time\":1406052000,\"duration\":1,\"availability\":0,\"customer_count\":0,\"boats\":[]}]"
      assert_equal(response.body, expected_response)
    end
  end

  def test_filters_by_date
    days = [
      ["2014-07-21", "[{\"id\":5,\"start_time\":1406012399,\"duration\":0,\"availability\":0,\"customer_count\":0,\"boats\":[]}]"],
      ["2014-07-22", "[{\"id\":3,\"start_time\":1406012400,\"duration\":1,\"availability\":0,\"customer_count\":0,\"boats\":[]},{\"id\":2,\"start_time\":1406052000,\"duration\":1,\"availability\":0,\"customer_count\":0,\"boats\":[]}]"],
      ["2014-07-23", "[{\"id\":4,\"start_time\":1406098800,\"duration\":1,\"availability\":0,\"customer_count\":0,\"boats\":[]}]"]
    ]

    days.each do |date, expected_response|
      get api_timeslots_url, params: {date: date}
      assert_equal(response.body, expected_response)
    end
  end

  def test_includes_timeslots_overlapping_date
    days = [
      ["2017-09-27", "[{\"id\":1,\"start_time\":1506520000,\"duration\":5,\"availability\":1000010,\"customer_count\":0,\"boats\":[{\"id\":4,\"name\":\"Funny, It Worked Last Time...\",\"capacity\":1000000},{\"id\":3,\"name\":\"Just Testing\",\"capacity\":10}]},{\"id\":6,\"start_time\":1505520000,\"duration\":16671,\"availability\":0,\"customer_count\":0,\"boats\":[]},{\"id\":7,\"start_time\":1505520000,\"duration\":33338,\"availability\":0,\"customer_count\":0,\"boats\":[]}]"],
    ]

    days.each do |date, expected_response|
      get api_timeslots_url, params: {date: date}
      assert_equal(response.body, expected_response)
    end
  end

  def test_create
    assert_difference('Timeslot.count', 1) do
      post api_timeslots_url, params: {timeslot: {start_time: 1406052000, duration: 120}}
      assert_response :success
      expected_response = "{\"id\":8,\"start_time\":1406052000,\"duration\":120,\"availability\":0,\"customer_count\":0,\"boats\":[]}"
      assert_equal(response.body, expected_response)
    end
  end
end
