class Usage < ActiveRecord::Base
  belongs_to :user
  belongs_to :spigot

# Gallons Per Minute of an average 100 ft long garden hose 
GPM = 12
def water_used
  minutes * GPM
end

def self.get_chart_data spigot_id
  spigot = Spigot.find(spigot_id)
  uses = spigot.usages.all
  dates = []
  used_minutes = []
  saved_minutes =[]
  uses.each do |u|
    dates.push "#{u.month}/#{u.day}/#{u.year}"
    used_minutes.push u.minutes
    saved_minutes.push u.water_saved
  end
  data ={
    labels: dates,
    used:{
      data: used_minutes
      },
      saved: {
        labels: dates,
        data:   saved_minutes, 
      }
  }
  end

  def self.bar_data spigot_id
    labels =[]
    numbers=[]
    spigot = Spigot.find(spigot_id)
    months = {
      1 =>'Jan', 
      2 => 'Feb', 
      3 => 'Mar', 
      4 => 'Apr', 
      5 => 'May', 
      6 => 'June', 
      7 => 'July', 
      8 => 'Aug', 
      9 => 'Sept', 
      10 => 'Oct', 
      11 => 'Nov', 
      12 => 'Dec'
    }
    current_month = Time.now.month
    if current_month >= 3
      month_range = [current_month -2, current_month -1, current_month]
    elsif current_month == 2
      month_range = [12, current_month -1, current_month]
    else
      month_range = [11, 12, current_month]
    end
    month_range.each do |x|
      usage_data= spigot.usages.where(month: x)
      gallons = 0
      usage_data.each do |u|
        gallons += u.water_used
      end
      numbers.push gallons
      labels.push months[x]
    end
    data ={
      labels: labels,
      numbers: numbers
      }
  end


end
