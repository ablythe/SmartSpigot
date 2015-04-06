require 'rails_helper'

RSpec.describe Usage, type: :model do
  before :each do
    @spigot = FactoryGirl.create :spigot
    5.times do 
      use = FactoryGirl.create :usage, spigot: @spigot
      use.update(
        created_at: rand(1..100).days.from_now, 
        wday: "Tuesday", 
        day: rand(1..30), 
        month: rand(1..12)
        )
    end
  end

  it "can create a new one" do
    s = FactoryGirl.create :spigot
    s.get_usage
    expect(s.usages.count).to eq 1
  end
 
  it "can display water amount" do
    water_data =@spigot.daily_water_usage
    expect(water_data[:total]).to eq 21120
  end

  it "can display usage by days" do
    FactoryGirl.create :usage, day: 16, month: 3, year: 2015, spigot:@spigot
    water_data =@spigot.daily_water_usage
    expect(water_data["3/16/2015"]).to eq 4224
  end

  it "can display usage by weeks" do
  end

  it "can display usage by month" do
  end

  it "can display usage by weekday" do
  end
end
