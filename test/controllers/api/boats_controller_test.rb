require 'test_helper'

class Api::BoatsControllerTest < ActionDispatch::IntegrationTest
  def test_gets_index
    get api_boats_url
    assert_response :success
    expected_response = "[{\"id\":1,\"name\":\"Another Fine Product From The Nonsense Factory\",\"capacity\":15},{\"id\":2,\"name\":\"Just Read The Instructions\",\"capacity\":40},{\"id\":3,\"name\":\"Just Testing\",\"capacity\":10},{\"id\":4,\"name\":\"Funny, It Worked Last Time...\",\"capacity\":1000000}]"
    assert_equal(response.body, expected_response)
  end

  def test_create
    assert_difference('Boat.count', 1) do
      post api_boats_url, params: {boat: {name: "Zodiac", capacity: "2"}}
      assert_response :success
      expected_response = "{\"id\":5,\"name\":\"Zodiac\",\"capacity\":2}"
      assert_equal(response.body, expected_response)
    end
  end
end
