require 'rails_helper'

RSpec.describe Spigot, type: :model do
  before :each do
    @spigot = FactoryGirl.create :spigot
  end
  it "can get a spigots watering schedule" do
    FactoryGirl.create :watering, spigot: @spigot
    schedule = @spigot.get_watering_schedule
    expect(schedule[:count]).to eq 1
    expect(schedule[:monday][1]).to eq 1
  end
end
