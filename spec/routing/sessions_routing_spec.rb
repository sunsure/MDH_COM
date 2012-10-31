require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes to /login #new" do
      get("/login").should route_to("sessions#new")
    end

    it "routes to /logout #new" do
     get("/logout").should route_to("sessions#destroy")
    end

    it "routes to #create" do
      post("/sessions").should route_to("sessions#create")
    end

    it "routes to /logout #new" do
      get("/unauthorized").should route_to("sessions#unauthorized")
    end
  end
end
