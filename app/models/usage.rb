class Usage < ActiveRecord::Base
  belongs_to :user
  belongs_to :spigot

# Gallons Per Minute of an average 100 ft long garden hose 
GPM = 12
def water_used
  minutes * GPM
end

def self.usage_by_month spigot
  data ={}
  (1..12).each do |x|
    data[x] =spigot.usages.where(month: x)
  end
  data
end

def self.usage_by_week spigot
  data ={}
  num = 1
  gallons = 0
  minutes = 0
  overrides = 0
  uses =spigot.usages.all
  uses.each do |u|
    unless u.week == "Sunday"
      minutes += u.minutes
      overrides += u.overrides
    else
      data["Week #{num}"]["minutes"] = minutes
      data["Week #{num}"]["gallons"] = minutes * GPM
      data["Week #{num}"]["overrides"] = overrides
      gallons = 0
      minutes = 0
      overrides = 0
      num += 1
    end
  end
end

def self.get_chart_data spigot_id
  spigot = Spigot.find(spigot_id)
  uses = spigot.usages.all
  dates = []
  minutes = []
  uses.each do |u|
    dates.push "#{u.month}/#{u.day}/#{u.year}"
    minutes.push u.minutes
  end
  data ={
    labels: dates,
    data: minutes
  }
  end


end
