require 'rails_helper'

RSpec.describe WateringsController, type: :controller do
  render_views
  before :each do
    @user= FactoryGirl.create :user
    login @user
    @spigot = FactoryGirl.create :spigot
  end
  it "can create a new watering" do
    params = {
      spigot_id: @spigot,
      watering:
      {
        'start_time(4i)' => '9',
        'start_time(5i)'=> '00',
        'end_time(4i)'=> '10',
        'end_time(5i)'=> '00',
        monday: true, 
        tuesday: false, 
        wednesday: true, 
        thursday: false, 
        friday: true, 
        saturday: false, 
        sunday: false}}
    post :create, params
    expect(response.code.to_i).to eq 302
    expect(@spigot.waterings.count).to eq 1
  end

it "can show a watering" do
  watering = FactoryGirl.create :watering, spigot: @spigot
  get :show, spigot_id: @spigot, id: watering
  expect(response.code.to_i).to eq 200
end

it "can edit a watering" do
  watering = FactoryGirl.create :watering, spigot: @spigot
  expect(watering.monday).to eq true
  expect(watering.saturday).to eq false
  params = {
    spigot_id: @spigot,
    id: watering,
    watering: {
      start_time: watering.start_time ,
      end_time: watering.end_time,
      monday: false,
      tuesday: watering.tuesday,
      wednesday: watering.wednesday,
      thursday: watering.thursday,
      friday: watering.friday,
      saturday: true,
      sunday: watering.sunday
      }}
      patch :update, params
      updated_watering = Watering.find(watering.id)
      expect(updated_watering.monday).to eq false
      expect(updated_watering.saturday).to eq true
    end

  end
