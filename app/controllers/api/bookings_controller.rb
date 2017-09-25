class Api::BookingsController < ApplicationController
  def create
    @booking = Booking.new(params.require(:booking).permit(:timeslot_id, :size))

    if @booking.save
      head :created
    elsif @booking.errors[:timeslot].include? "must exist"
      head :not_found
    else
      head :unprocessable_entity
    end
  end
end
