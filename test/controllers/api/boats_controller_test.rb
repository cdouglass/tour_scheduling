require 'test_helper'

class Api::BoatsControllerTest < ActionDispatch::IntegrationTest
  def test_gets_index
    get api_boats_url
    assert_response :success
    expected_response = "[{\"id\":476007621,\"name\":\"Funny, It Worked Last Time...\",\"capacity\":1000000},{\"id\":642448160,\"name\":\"Another Fine Product From The Nonsense Factory\",\"capacity\":15},{\"id\":858695237,\"name\":\"Just Read The Instructions\",\"capacity\":40},{\"id\":1015256526,\"name\":\"Pelagian\",\"capacity\":2},{\"id\":1064137960,\"name\":\"Just Testing\",\"capacity\":10}]"
    assert_equal(response.body, expected_response)
  end

  def test_create
    assert_difference('Boat.count', 1) do
      post api_boats_url, params: {boat: {name: "Zodiac", capacity: "2"}}
      assert_response :success
      expected_response = "{\"id\":1064137961,\"name\":\"Zodiac\",\"capacity\":2}"
      assert_equal(response.body, expected_response)
    end
  end
end
