require "spec_helper"

describe MyController do

  describe "routing" do
    let(:url) { "http://www.example.com" }
    let(:bad_url) { "http://www.example.com/admin" }

    describe "success" do
      it "routes to my#dashboard" do
        get("#{url}/dashboard").should route_to("my#dashboard")
      end
    end

    describe "failure" do
      it "doesnt route to admin/my#dashboard" do
        get("#{bad_url}/dashboard").should_not route_to("admin/my#dashboard", subdomain: "admin")
      end
    end
  end
end
