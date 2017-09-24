class Timeslot < ApplicationRecord

  attr_accessor :duration

  validates_numericality_of [:start_time, :duration], only_integer: true, greater_than: 0

  after_validation :set_end_time

  def duration
    @duration ||= (self.end_time - self.start_time) / 60
  end

  def initialize(attributes={})
    self.duration = attributes[:duration]
    super
  end

  def as_json(options = {})
    json = super(options)
    json[:duration] = self.duration.to_i
    json
  end

  def Timeslot.all_on_date(date)
    # convert to time so #midnight considers time zone
    date_start = date.to_time.midnight.to_i
    date_end = (date + 1.day).to_time.midnight.to_i - 1
    Timeslot.where("(start_time BETWEEN :date_start AND :date_end) OR (end_time BETWEEN :date_start_exclusive AND :date_end) OR (start_time < :date_start AND end_time > :date_end)", {date_start: date_start, date_end: date_end, date_start_exclusive: date_start + 1})
  end

  private

  def set_end_time
    if (self.end_time.nil? || self.end_time < 0) && self.errors.empty?
      self.end_time = self.start_time + 60 * @duration.to_i
    end
  end
end
