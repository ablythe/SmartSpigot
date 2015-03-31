class CreateWaterings < ActiveRecord::Migration
  def change
    create_table :waterings do |t|
      t.belongs_to :spigot, index: true
      t.time :start_time
      t.time :end_time
      t.boolean :monday, null:false, default:false
      t.boolean :tuesday, null:false, default:false
      t.boolean :wednesday, null:false, default:false
      t.boolean :thursday, null:false, default:false
      t.boolean :friday, null:false, default:false
      t.boolean :saturday, null:false, default:false
      t.boolean :sunday, null:false, default:false

      t.timestamps null: false
    end
    add_foreign_key :waterings, :spigot
  end
end
