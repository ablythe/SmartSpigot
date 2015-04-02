class CreateWeatherApi < ActiveRecord::Migration
  def change
    create_table :weather_apis do |t|
      t.integer :precip_chance
      t.integer :temp_min
      t.integer :temp_max
      t.belongs_to :spigot
      t.timestamps null:false
    end
  end
end
