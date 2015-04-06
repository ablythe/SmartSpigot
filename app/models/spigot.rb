class Spigot < ActiveRecord::Base
  belongs_to :user
  has_many :waterings
  has_many :weather_apis
  geocoded_by :address
  after_validation :geocode

  def address
    "#{street_address}, #{city}, #{state}, #{country}"
  end

  def get_days_weather
    weather = weather_apis.where("created_at > ?", Time.now.midnight).first
    unless weather
      weather = store_days_weather
    end
    weather
  end

  def store_days_weather 
    response =WeatherApi.current_forecast latitude, longitude
    data = WeatherApi.parse_data response
    weather_apis.create!(data)
  end

  def get_watering_schedule
    data =waterings.all.order(start_time: :asc)
    days = %w(monday tuesday wednesday thursday friday saturday sunday)
    schedule =
    {
      monday: [],
      tuesday: [],
      wednesday: [],
      thursday: [],
      friday: [],
      saturday: [],
      sunday: []
    }
    data.each do |watering|
      days.each do |day|
        if watering[day]
          schedule[day.to_sym].push(
            "#{watering.parse_time watering.start_time} - #{watering.parse_time watering.end_time}", 
            watering.id
            )
        end
      end
    end
    schedule[:count] = find_max schedule
    schedule
  end

  def change_state? new_state, time
    weekday = get_day
    end_times = waterings.where("#{weekday}": true).map {|w| w[time]}
    end_times.each do |t|
      hour =Time.now.utc.hour
      minute = Time.now.utc.min
      if hour == t.hour && minute == t.min
        self.send(new_state)
      end
    end
  end

  def get_day
    weekday = Time.now.getlocal.strftime('%A').downcase
  end

  def on
    HTTParty.get("http://#{ip}:70/L")
  end

  def off
    HTTParty.get("http://#{ip}:70/H")
  end

  

  private

  def find_max schedule
    max =0
    schedule.each_value do |v|
      if v.count > max 
        max= v.count 
      end
    end
    max/2
  end

end
