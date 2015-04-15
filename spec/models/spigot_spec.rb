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

  it "can turn a spigot on and off" do
  end

  it "knows when to turn on a spigot" do
  end

  it "knows when to turn off a spigot" do
  end

  it "knows to override for weather" do
  end
end
