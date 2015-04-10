class UsagesController <ApplicationController

def minutes
  @spigot = Spigot.find(params["spigot_id"])
  @chart_data = Usage.get_chart_data @spigot
end

def gallons
  @spigot = Spigot.find(params["spigot_id"])
  @bar_data =Usage.bar_data @spigot
end

end