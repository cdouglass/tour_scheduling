class Assignment < ApplicationRecord
  belongs_to :boat
  belongs_to :timeslot

  validates :boat, presence: true
  validates :timeslot, presence: true

  validate :no_overlap

  private

  def no_overlap
    if self.errors.empty?
      overlapping = Timeslot.all_overlapping_range(self.timeslot.start_time, self.timeslot.end_time)
        .joins(:assignments)
        .where(assignments: {boat_id: self.boat_id})
        .where.not(assignments: {id: self.id})

      if overlapping.any?
        errors.add(:boat, "Not available for that timeslot")
      end
    end
  end
end
