require "spec_helper"

describe MyController do

  describe "routing" do
    let(:url) { "http://www.example.com" }
    let(:bad_url) { "http://www.example.com/admin" }

    describe "success" do
      it "routes to my#dashboard" do
        get("#{url}/my/dashboard").should route_to("my#dashboard")
      end
      it "routes to my#comments" do
        get("#{url}/my/comments").should route_to("my#comments")
      end
      it "routes PUT to my#profile" do
        put("#{url}/my/profile").should route_to("users#update")
      end
      it "routes GET to my#profile" do
        get("#{url}/my/profile/edit").should route_to("users#edit")
      end
    end

    describe "failure" do
      it "doesnt route to admin/my#dashboard" do
        get("#{bad_url}/my/dashboard").should_not route_to("admin/my#dashboard")
      end
      it "doesnt route to admin/my#comments" do
        get("#{bad_url}/my/comments").should_not route_to("admin/my#comments")
      end
      it "doesnt route PUT to my#profile" do
        put("#{bad_url}/my/profile").should_not route_to("admin/users#update")
      end
      it "doesnt route GET to my#profile" do
        put("#{bad_url}/my/profile/edit").should_not route_to("admin/users#edit")
      end
    end
  end
end
