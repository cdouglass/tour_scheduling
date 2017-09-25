require 'test_helper'

class Api::BookingsControllerTest < ActionDispatch::IntegrationTest
  def test_create
    assert_difference('Booking.count', 1) do
      timeslot = timeslots(:one)
      post api_bookings_url, params: {booking: {timeslot_id: timeslot.id, size: 4}}
      assert_response :created
    end
  end

  def test_create_with_invalid_timeslot
    assert_no_difference('Booking.count') do
      post api_bookings_url, params: {booking: {timeslot_id: 999, size: 4}}
      assert_response :not_found
    end
  end

  def test_create_with_insufficient_availability
    assert_no_difference('Booking.count') do
      timeslot = timeslots(:before_and_after_day_one)
      post api_bookings_url, params: {booking: {timeslot_id: timeslot.id, size: 4}}
      assert_response :unprocessable_entity
    end
  end
end
