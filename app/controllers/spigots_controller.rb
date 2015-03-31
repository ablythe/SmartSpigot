class SpigotsController < ApplicationController
  def new
    @spigot = Spigot.new
  end

  def create
    @spigot = current_user.spigots.create(name: params['spigot'][:name], isp: params['spigot']['isp'], location: params['spigot']["location"], zipcode: params['spigot']["zipcode"])
    redirect_to spigot_path @spigot
  end

  def show
    @spigot =Spigot.find(params['id'])
    @city = ZipCodes.identify(@spigot.zipcode.to_s)[:city]
    @status = @spigot.on ? "On" : "Off"
  end

  def index
    @spigots = current_user.spigots.all
  end

end
