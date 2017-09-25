class Booking < ApplicationRecord

  belongs_to :timeslot

  validates :timeslot, presence: true
  validates_numericality_of :size, only_integer: true, greater_than: 0

  validate :sufficient_availability

  private

  def sufficient_availability
    if self.errors.empty?
      if self.timeslot.availability < self.size
        self.errors.add(:timeslot, "not enough room")
      end
    end
  end

end
