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
    weather_apis.where("created_at > ?", Time.now.midnight).first
  end

  def store_days_weather 
    response =WeatherApi.current_forecast latitude, longitude
    data = WeatherApi.parse_data response
    weather_apis.create!(data)
  end
end
