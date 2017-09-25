class Timeslot < ApplicationRecord

  has_many :assignments
  has_many :boats, through: :assignments
  has_many :bookings

  attr_accessor :duration

  validates_numericality_of [:start_time, :duration], only_integer: true, greater_than: 0

  after_validation :set_end_time

  def duration
    @duration ||= (self.end_time - self.start_time) / 60
  end

  def availability
    self.boats.reduce(0) {|sum, boat| sum + boat.capacity}
  end

  def customer_count
    0
  end

  def initialize(attributes={})
    self.duration = attributes[:duration]
    super
  end

  def as_json(options = {})
    json = super(except: [:created_at, :updated_at, :end_time])
    json[:duration] = self.duration.to_i
    json[:availability] = self.availability
    json[:customer_count] = self.customer_count
    json[:boats] = self.boats
    json
  end

  def Timeslot.all_on_date(date)
    # convert to time so #midnight considers time zone
    date_start = date.to_time.midnight.to_i
    date_end = (date + 1.day).to_time.midnight.to_i - 1
    Timeslot.all_overlapping_range(date_start, date_end)
  end

  def Timeslot.all_overlapping_range(start_time, end_time)
    Timeslot.where("(start_time BETWEEN :start_time AND :end_time) OR (end_time BETWEEN :start_time_exclusive AND :end_time) OR (start_time < :start_time AND end_time > :end_time)", {start_time: start_time, end_time: end_time, start_time_exclusive: start_time + 1})
  end

  private

  def set_end_time
    if (self.end_time.nil? || self.end_time < 0) && self.errors.empty?
      self.end_time = self.start_time + 60 * @duration.to_i
    end
  end
end
