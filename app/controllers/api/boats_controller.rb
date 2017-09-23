class Api::BoatsController < ApplicationController
  def index
    @boats = Boat.all

    render json: @boats, only: boat_fields
  end

  def create
    @boat = Boat.new(params.require(:boat).permit(:name, :capacity))

    @boat.save

    render json: @boat, only: boat_fields
  end

  private

  def boat_fields
    [:id, :name, :capacity]
  end
end
