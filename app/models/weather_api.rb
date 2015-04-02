class WeatherApi < ActiveRecord::Base
  belongs_to :spigot
  APIKEY = ENV['weather_key']

  def self.current_forecast lat, long
    response =HTTParty.get("https://api.forecast.io/forecast/#{APIKEY}/#{lat},#{long}")
  end

  def self.parse_data response
    day = response["daily"]["data"].first
    data ={
      precip_chance: (day["precipProbability"].to_f * 100),
      temp_min: day['temperatureMin'].to_i,
      temp_max: day['temperatureMax'].to_i
      }
  end
end
