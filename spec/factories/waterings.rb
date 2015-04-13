FactoryGirl.define do
  factory :watering do
    spigot nil
    start_time "2000-01-01 13:00:00 UTC"
    end_time "2000-00-01 13:15:00 UTC"
    duration 900
    monday true
    wednesday true
    friday true
  end

end
