class SpigotsController < ApplicationController
  def new
    @spigot = Spigot.new
  end

  def create
    @spigot = current_user.spigots.create(name: params[:name], isp: params['isp'])
    redirect_to spigot_path @spigot
  end

  def show
    @spigot =Spigot.find(params['id'])
  end

  def index
    @spigots = current_user.spigots.all
  end

  def update
    
  end
end
