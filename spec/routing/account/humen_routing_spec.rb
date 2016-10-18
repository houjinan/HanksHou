require "rails_helper"

RSpec.describe Account::HumenController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/account/humen").to route_to("account/humen#index")
    end

    it "routes to #new" do
      expect(:get => "/account/humen/new").to route_to("account/humen#new")
    end

    it "routes to #show" do
      expect(:get => "/account/humen/1").to route_to("account/humen#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/account/humen/1/edit").to route_to("account/humen#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/account/humen").to route_to("account/humen#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/account/humen/1").to route_to("account/humen#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/account/humen/1").to route_to("account/humen#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/account/humen/1").to route_to("account/humen#destroy", :id => "1")
    end

  end
end
