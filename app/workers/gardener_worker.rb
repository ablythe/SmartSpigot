class GardenerWorker 
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence {minutely.second_of_minute(30)}

  def perform
    spigots = Spigot.all
    spigots.each do |spigot|
      if spigot.status == "On"
        spigot.turn_off?
      else
        spigot.turn_on?
      end
    end
  end

end