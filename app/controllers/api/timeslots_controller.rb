class Api::TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.all

    render json: @timeslots, only: timeslot_fields
  end

  def create
    @timeslot = Timeslot.new(params.require(:timeslot).permit(:start_time, :duration))

    @timeslot.save

    render json: @timeslot, only: timeslot_fields
  end

  private

  def timeslot_fields
    [:id, :start_time, :duration]
  end
end
