class Api::TimeslotsController < ApplicationController
  def index
    today = Date.current
    date_string = search_params[:date]
    begin
      @date = date_string.nil? ? today : date_string.to_date
    rescue ArgumentError
      @date = today
    end

    @timeslots = Timeslot.all_on_date(@date)

    render json: @timeslots, only: timeslot_fields
  end

  def create
    # in minutes
    duration = create_params[:duration].to_i

    # times in seconds from epoch
    @timeslot = Timeslot.new(create_params[:timeslot])
    @timeslot.end_time = @timeslot.start_time + 60 * duration

    @timeslot.save

    render json: @timeslot, only: timeslot_fields
  end

  private

  def timeslot_fields
    [:id, :start_time, :duration]
  end

  def search_params
    params.permit(:date)
  end

  def create_params
    { timeslot: params.require(:timeslot).permit(:start_time),
      duration: params.require(:timeslot).permit(:duration)[:duration] }
  end
end
