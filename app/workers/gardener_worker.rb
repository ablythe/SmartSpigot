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
        if spigot.on?
          changed = spigot.change_state? 'off', 'end_time'
        else
          changed = spigot.change_state? 'on', 'start_time'
        end
        if changed
          Usage.duration data

      else
        todays_use.overrides += 1
        todays_use.save!
      end
    end
  end

end