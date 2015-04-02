class CreateSpigots < ActiveRecord::Migration
  def change
    create_table :spigots do |t|
      t.string :name
      t.string :isp
      t.string :location
      t.float  :latitude
      t.float  :longitude
      t.string :zipcode
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.integer :threshold
      t.boolean :on
      t.datetime :user_overriden
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :spigots, :users
  end
end
