class CreateSpigots < ActiveRecord::Migration
  def change
    create_table :spigots do |t|
      t.string :name
      t.string :isp
      t.string :location
      t.integer :zipcode
      t.integer :threshold
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :spigots, :users
  end
end
