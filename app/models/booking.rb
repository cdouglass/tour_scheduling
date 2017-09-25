class Booking < ApplicationRecord

  belongs_to :timeslot

  validates :timeslot, presence: true
  validates_numericality_of :size, only_integer: true, greater_than: 0

end
