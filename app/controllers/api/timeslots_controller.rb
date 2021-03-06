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

    render json: @timeslots, except: hidden_fields
  end

  def create
    @timeslot = Timeslot.new(params.require(:timeslot).permit(:start_time, :duration))

    @timeslot.save

    render json: @timeslot, except: hidden_fields
  end

  private

  def hidden_fields
    [:created_at, :updated_at, :end_time]
  end

  def search_params
    params.permit(:date)
  end
end
