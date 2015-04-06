class GardenerWorker 
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence {secondly(30)}

  def perform
    spigots =Spigot.all
    spigots.each do |spigot|
      weather= spigot.get_days_weather
      spigot.get_usage
      unless weather.precip_chance >= spigot.threshold
        if spigot.on?
          spigot.change_state? 'off', 'end_time'
        else
          spigot.change_state? 'on', 'start_time'
        end
      end
    end
  end

end