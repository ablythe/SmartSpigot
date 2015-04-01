class WateringsController < ApplicationController
  def create
    @spigot = Spigot.find(params['spigot_id'])
    @spigot.waterings.create( 
      start_time: params['start_time'], 
      end_time: params['end_time'],
      monday: params['monday'],
      tuesday: params['tuesday'],
      wednesday: params['wednesday'],
      thursday: params['thursday'],
      friday: params['friday'],
      saturday: params['saturday'],
      sunday: params['sunday'])
    redirect_to spigots_path @spigot
  end

  def show
    @watering = Watering.find(params[:id])
    @start_time = @watering.parse_time @watering.start_time
    @end_time = @watering.parse_time @watering.end_time
  end
end
