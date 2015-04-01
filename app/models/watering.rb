class Watering < ActiveRecord::Base
  belongs_to :spigot

  def parse_time time 
    hour = time.localtime.hour
    minute = time.localtime.min
    if minute.to_s.length == 1
      minute = "0" + minute.to_s
    end
    am_pm = if hour == 24 || hour < 12
      "AM"
    else
      "PM"
    end
    return "#{hour}:#{minute} #{am_pm}"
  end
end
