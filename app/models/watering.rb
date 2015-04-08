class Watering < ActiveRecord::Base
  belongs_to :spigot

  def parse_time time 
    time.getlocal.strftime("%I:%M%p")
  end

  def self.to_utc hour, minute
    time = Time.now(2000,1,1, hour, minute)
  end



end
