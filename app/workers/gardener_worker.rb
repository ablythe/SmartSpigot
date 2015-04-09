class GardenerWorker 
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence {secondly(30)}

  def perform
    spigots = Spigot.all
    spigots.each do |spigot|
      weather = spigot.get_days_weather
      todays_use = spigot.get_usage
      unless weather.precip_chance >= spigot.threshold
        if spigot.status == "On"
          spigot.turn_off?
        else
          spigot.turn_on?
        end
      else
        todays_use.overrides += 1
        todays_use.save!
      end
    end
  end

end