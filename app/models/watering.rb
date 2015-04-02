class Watering < ActiveRecord::Base
  belongs_to :spigot

  def parse_time time 
    time.strftime("%I:%M%p")
  end
end
