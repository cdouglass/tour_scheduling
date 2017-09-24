class Api::AssignmentsController < ApplicationController
  def create
    boat = Boat.find_by(id: assignment_params[:boat_id])
    timeslot = Timeslot.find_by(id: assignment_params[:timeslot_id])
    if boat.nil? || timeslot.nil?
      head :not_found
    else
      @assignment = Assignment.new(boat: boat, timeslot: timeslot)
      if @assignment.save
        head :created
      elsif @assignment.errors[:boat].include? "Not available for that timeslot"
        head :unprocessable_entity
      end
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:boat_id, :timeslot_id)
  end
end
