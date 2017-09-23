require 'test_helper'

class Api::BoatsControllerTest < ActionDispatch::IntegrationTest
  def test_gets_index
    get api_boats_url
    assert_response :success
    expected_response = "[{\"id\":298486374,\"name\":\"MyString\",\"capacity\":1},{\"id\":980190962,\"name\":\"MyString\",\"capacity\":1}]"
    assert_equal(response.body, expected_response)
  end

  def test_create
    assert_difference('Boat.count', 1) do
      post api_boats_url, params: {boat: {name: "Zodiac", capacity: "2"}}
      assert_response :success
      expected_response = "{\"id\":980190963,\"name\":\"Zodiac\",\"capacity\":2}"
      assert_equal(response.body, expected_response)
    end
  end
end
