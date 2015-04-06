class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.belongs_to :user, index: true
      t.belongs_to :spigot, index: true
      t.integer :minutes
      t.integer :overrides

      t.timestamps null: false
    end
    add_foreign_key :days, :users
    add_foreign_key :days, :spigots
  end
end
