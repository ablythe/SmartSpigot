class GardenerWorker 
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  def perform
    spigots =Spigot.all
    spigots.each do |spigot|
      weather= spigot.get_days_weather
      unless weather.precip_chance >= spigot.threshold
        if spigot.on?
          spigot.turn_off?
      end

      # check if on?
        # if on then check if there is a turn off within seconds
          # if yes send 0
          # else
            # do nothing
      # check if watering is within 10 seconds
        # if yes send 1  
  end

end