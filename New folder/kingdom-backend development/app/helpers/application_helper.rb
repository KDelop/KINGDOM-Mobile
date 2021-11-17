module ApplicationHelper
  def date_translation(date)
    date = date.to_date unless date.kind_of? Date

    case date
    when Date.today
      'Today'
    when Date.today.next_day
      'Tomorrow'
    else
      date.strftime('%A, %B %e')
    end
  end

  def select_time_drop_down_values
    select_time = []
    ('2020-01-01'.to_datetime.to_i..'2020-01-02'.to_datetime.to_i).step(30.minutes) do |date|
      select_time <<
        (
          Time
            .at(date)
            .strftime(
              '%l:%M' \
              ' %p'
            )
        ).to_s
    end
    return select_time
  end
end
