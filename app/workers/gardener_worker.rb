class GardenerWorker 
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence {secondly(30)}

  def perform
    spigots = Spigot.all
    spigots.each do |spigot|
      weather = spigot.access_days_weather
      todays_use = spigot.get_usage
      unless weather.precip_chance >= spigot.threshold
        if spigot.status == "On"
          spigot.turn_off?
        else
          spigot.turn_on?
        end
      else
        day = todays_use["wday"]
        todays_use.overrides = spigot.waterings.where("#{day}": true).count
        todays_use.save!
      end
    end
  end

end