require 'rails_helper'

RSpec.describe SpigotsController, type: :controller do
  render_views
  before :each do
    @user= FactoryGirl.create :user
    login @user
  end
  it "can create a new controller" do
    get :new
    expect(response.code.to_i).to eq 200
    post :create, name: "Spigot1", isp: "1.1.0"
    expect(@user.spigots.count).to eq 1
    expect(response.code.to_i).to eq 302
  end

  it "can list spigots" do
    get :index
    expect(response.code.to_i).to eq 200
    expect(response.body).to include "Spigots"
  end

  it "can show a specific spigot" do
    spigot = FactoryGirl.create :spigot 
    get :show, id: spigot.id
    expect(response.code.to_i).to eq 200
  end

  it "knows a spigot's city" do
    spigot = FactoryGirl.create :spigot
    get :show, id: spigot.id
    expect(response.body).to include "Washington"
  end

  it "knows if a spigot is on" do
    spigot =FactoryGirl.create :spigot
    get :show, id: spigot.id
    expect(response.body).to include "Status: Off"
    spigot.on = true
    spigot.save
    get :show, id: spigot.id
    expect(response.body).to include "Status: On"
  end

end
