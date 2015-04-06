class CreateUsages < ActiveRecord::Migration
  def change
    create_table :usages do |t|
      t.belongs_to :user, index: true
      t.belongs_to :spigot, index: true
      t.integer :minutes
      t.integer :overrides
      t.integer :avg_temp
      t.string  :wday
      t.integer :day
      t.integer :month
      t.integer :year
      

      t.timestamps null: false
    end
    add_foreign_key :usages, :users
    add_foreign_key :usages, :spigots
  end
end
