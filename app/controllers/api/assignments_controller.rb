class Api::AssignmentsController < ApplicationController
  def create
    @assignment = Assignment.new(params.require(:assignment).permit(:boat_id, :timeslot_id))

    if @assignment.save
      head :created
    end
  end
end
