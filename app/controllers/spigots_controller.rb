class SpigotsController < ApplicationController
  def new
    @spigot = Spigot.new
  end

  def create
    @spigot = current_user.spigots.create(
      name: params['spigot'][:name], 
      ip: params['spigot']['ip'], 
      street_address: params['spigot']['street_address'],
      city: params['spigot']['city'],
      state: params['spigot']['state'],
      country: params['spigot']['country'],
      zipcode: params['spigot']["zipcode"],
      timezone: params["spigot"]['timezone'],
      threshold: params['spigot']['threshold']
      )
    redirect_to spigot_path @spigot
  end

  def show
    @spigot =Spigot.find(params['id'])
    @status = @spigot.status
    @weather =@spigot.access_days_weather
    @watering_days =@spigot.get_watering_schedule
  end

  def index
    @spigots = current_user.spigots.all
  end

  def update
    @spigot =Spigot.find(params['id'])
    @spigot.update! name: params["spigot"]['name'], threshold: params['spigot']['threshold']
    redirect_to :back, alert:"Spigot Updated"
  end

  def on
    @spigot = Spigot.find(params['spigot_id'])
    @spigot.on
    redirect_to :back, alert: "Spigot Turned On"
  end

  def off
    @spigot = Spigot.find(params['spigot_id'])
    @spigot.off
    redirect_to :back, alert: "Spigot Turned Off"
  end

end
