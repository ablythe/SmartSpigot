class Usage < ActiveRecord::Base
  belongs_to :user
  belongs_to :spigot

# Gallons Per Minute of an average 100 ft long garden hose 
GPM = 12
def water_used
  minutes * GPM
end
  
end
