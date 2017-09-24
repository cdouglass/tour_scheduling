require 'test_helper'

class BoatTest < ActiveSupport::TestCase
  def setup
    @boat = Boat.new(name: "Pangolin", capacity: 6)
  end

  def test_valid_boat
    assert @boat.valid?
  end

  def test_boat_requires_name
    ["", nil].each do |val|
      @boat.name = val
      assert @boat.invalid?
    end
  end

  def test_capacity_requires_positive_integer
    ["foo", nil, 10.5, 0, -10].each do |val|
      @boat.capacity = val
      assert @boat.invalid?
    end
  end
end
