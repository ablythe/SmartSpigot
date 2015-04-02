class Spigot < ActiveRecord::Base
  belongs_to :user
  has_many :waterings
  geocoded_by :address
  after_validation :geocode

  def address
    "#{street_address}, #{city}, #{state}, #{country}"
  end


end
