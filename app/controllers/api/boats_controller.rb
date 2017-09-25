class Api::BoatsController < ApplicationController
  def index
    @boats = Boat.all

    render json: @boats
  end

  def create
    @boat = Boat.new(params.require(:boat).permit(:name, :capacity))

    @boat.save

    render json: @boat
  end
end
