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
      it "routes to my#inbox" do
        get("#{url}/my/inbox").should route_to("my#inbox")
      end
    end

    describe "failure" do
      it "doesnt route to admin/my#dashboard" do
        get("#{bad_url}/my/dashboard").should_not route_to("admin/my#dashboard")
      end
      it "doesnt route to admin/my#comments" do
        get("#{bad_url}/my/comments").should_not route_to("admin/my#comments")
      end
      it "doesnt route to admin/my#inbox" do
        get("#{bad_url}/my/inbox").should_not route_to("admin/my#inbox")
      end
    end
  end
end
