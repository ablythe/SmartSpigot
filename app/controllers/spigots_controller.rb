class SpigotsController < ApplicationController
  def new
    @spigot = Spigot.new
  end

  def create
    @spigot = current_user.spigots.create(
      name: params['spigot'][:name], 
      ip: params['spigot']['ip'], 
      location: params['spigot']["location"], 
      street_address: params['spigot']['street_address'],
      city: params['spigot']['city'],
      state: params['spigot']['state'],
      country: params['spigot']['country'],
      zipcode: params['spigot']["zipcode"]
      )
    redirect_to spigot_path @spigot
  end

  def show
    @spigot =Spigot.find(params['id'])
    @status = @spigot.on ? "On" : "Off"
    @weather =@spigot.get_days_weather
    @watering_days =@spigot.get_watering_schedule
  end

  def index
    @spigots = current_user.spigots.all
  end

end
