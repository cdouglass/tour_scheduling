class Api::BoatsController < ApplicationController
  def index
  end

  def create
    @boat = Boat.new(params.require(:boat).permit(:name, :capacity))

    @boat.save

    render @boat
  end
end
