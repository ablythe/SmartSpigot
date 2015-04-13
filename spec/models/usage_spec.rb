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
 


  

  

  
end
