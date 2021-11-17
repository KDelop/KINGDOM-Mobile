class Availability < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, :day_of_week, presence: true

  def duration
    "#{day_of_week} #{start_time.strftime('%l:%M %P')} - #{end_time.strftime('%l:%M %P')}"
  end
end
