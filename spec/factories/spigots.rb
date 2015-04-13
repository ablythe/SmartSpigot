FactoryGirl.define do
  factory :spigot do
    name "Spigot1"
    ip "1.0.0.1.0"
    street_address "1600 Pennsylvannia Ave NW"
    city  "Washington"
    state "DC"
    country "United States"
    zipcode 20009
    threshold 70
    timezone "Eastern Time (US & Canada)"
    status "Off"
  end

end
