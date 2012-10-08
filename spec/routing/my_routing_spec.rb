require "spec_helper"

describe MyController do

  describe "routing" do
    it "routes to /login #new" do
      get("/dashboard").should route_to("my#dashboard")
    end
  end
end
