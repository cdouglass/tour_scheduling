class Boat < ApplicationRecord

  validates_presence_of :name
  validates_numericality_of :capacity, only_integer: true, greater_than: 0

end
