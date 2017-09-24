class Timeslot < ApplicationRecord

  validates_numericality_of [:start_time, :end_time], only_integer: true

  validate :end_after_start

  def duration
    (self.end_time - self.start_time) / 60
  end

  def as_json(options = {})
    json = super(options)
    json[:duration] = self.duration
    json
  end

  def Timeslot.all_on_date(date)
    # convert to time so #midnight considers time zone
    date_start = date.to_time.midnight.to_i
    date_end = (date + 1.day).to_time.midnight.to_i - 1
    Timeslot.where("(start_time BETWEEN :date_start AND :date_end) OR (end_time BETWEEN :date_start_exclusive AND :date_end) OR (start_time < :date_start AND end_time > :date_end)", {date_start: date_start, date_end: date_end, date_start_exclusive: date_start + 1})
  end

  private

  def end_after_start
    if self.errors.empty? && self.end_time <= self.start_time
      errors.add(:end_time, "Duration must be a positive number")
    end
  end

end
