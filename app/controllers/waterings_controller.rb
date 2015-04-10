class WateringsController < ApplicationController
  def new
    @watering=Watering.new
    @spigot = Spigot.find(params[:spigot_id])
  end

  def create
    @spigot = Spigot.find(params['spigot_id'])
    data = params['watering']
    start_time = Time.new(2000, 1, 1,data['start_time(4i)'], data['start_time(5i)'])
    end_time = Time.new(2000,1,1,data['end_time(4i)'], data['end_time(5i)'])
    @spigot.waterings.create( 
      start_time: start_time, 
      end_time: end_time,
      duration: end_time - start_time,
      monday: data['monday'],
      tuesday: data['tuesday'],
      wednesday: data['wednesday'],
      thursday: data['thursday'],
      friday: data['friday'],
      saturday: data['saturday'],
      sunday: data['sunday'])
    redirect_to spigot_path @spigot
  end

  def show
    @watering = Watering.find(params[:id])
    @start_time = @watering.parse_time @watering.start_time
    @end_time = @watering.parse_time @watering.end_time
  end

  def update
    @spigot = Spigot.find(params[:spigot_id])
    @watering = Watering.find(params[:id])
    data = params["watering"]
    @watering.update(
      start_time: data["start_time"],
      end_time: data["end_time"],
      monday: data['monday'],
      tuesday: data['tuesday'],
      wednesday: data['wednesday'],
      thursday: data['thursday'],
      friday: data['friday'],
      saturday: data['saturday'],
      sunday: data['sunday']
      ) 
    redirect_to spigot_watering_path, spigot_id: @spigot, id: @watering
  end

  def destroy
    Watering.find(params['id']).delete
    redirect_to spigot_path id: params['spigot_id']
  end
end
