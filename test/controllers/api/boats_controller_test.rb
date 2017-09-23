require 'test_helper'

class Api::BoatsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def test_gets_index
    get api_boats_url
    assert_response :success
  end

  def test_create
    assert_difference('Boat.count', 1) do
      post api_boats_url, params: {boat: {name: "Zodiac", capacity: "2"}}
    end
  end
end
