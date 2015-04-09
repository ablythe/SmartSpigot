class UsagesController <ApplicationController

def data
  @spigot = Spigot.find(params["spigot_id"])
  @chart_data = Usage.get_chart_data @spigot
end

end