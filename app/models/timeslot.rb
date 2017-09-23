class Timeslot < ApplicationRecord

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
    date_end = (date + 1.day).to_time.midnight.to_i
    Timeslot.where(start_time: date_start...date_end)
  end

end
