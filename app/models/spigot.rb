class Spigot < ActiveRecord::Base
  belongs_to :user
  has_many :waterings
  has_many :weather_apis
  has_many :usages
  geocoded_by :address
  after_validation :geocode

  def address
    "#{street_address}, #{city}, #{state}, #{country}"
  end

  def access_days_weather
    weather = weather_apis.where("created_at > ?", Time.now.midnight.utc).first || fetch_days_weather
  end

  def fetch_days_weather 
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

  def turn_on? 
    weekday = get_day
    waters = waterings.where("#{weekday}": true).all
    waters.each do |water|
      t = water.start_time
      Time.zone = timezone
      hour =Time.zone.now.hour
      minute = Time.zone.now.min
      if hour == t.getlocal.hour && minute == t.getlocal.min
        usage = get_usage
        if not_rainy?
          self.on
          usage.minutes += (water.duration / 60)
          usage.save!
        else
          usage.water_saved += (water.duration / 60)
          usage.overrides += 1
          usage.save!
        end
      end
    end
  end

  def turn_off? 
    weekday = get_day
    waters = waterings.where("#{weekday}": true).all
    waters.each do |water|
      t = water.end_time
      Time.zone = timezone
      hour =Time.zone.now.hour
      minute = Time.zone.now.min
      if hour == t.getlocal.hour && minute == t.getlocal.min
        self.off
      end
    end
  end

  def get_day
    Time.zone = timezone
    weekday = Time.zone.now.strftime('%A').downcase
  end

  def on 
    # HTTParty.get("http://#{ip}:70/L")
    update status:"On"
  end

  def off
    # HTTParty.get("http://#{ip}:70/H")
    update status: "Off"
  end

  def get_usage
    usages.where("created_at > ?", Time.now.midnight.utc).first_or_create!(
      minutes: 0, 
      water_saved: 0,
      overrides: 0, 
      wday: get_day,
      day: Time.now.day,
      month: Time.now.month,
      year: Time.now.year
      )
  end

  def not_rainy?
    weather = access_days_weather
    weather.precip_chance < threshold
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
