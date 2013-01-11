require "spec_helper"

describe UsersController do
  describe "routing" do
    let(:url)     { "http://www.example.com" }
    let(:bad_url) { "http://www.example.com/admin" }

    describe "success" do
      # the regular controller
      it "routes to #new" do
        get("#{url}/register").should route_to("users#new")
      end

      it "routes to #create" do
        post("#{url}/users").should route_to("users#create")
      end

      it "routes to #destroy" do
        delete("#{url}/users/1").should route_to("users#destroy", id: "1")
      end
    end

    describe "failure" do
      # the admin routes shouldn't route to the regular controller
      it "routes to #new" do
        get("#{bad_url}/new").should_not route_to("users#new")
      end

      it "routes to #create" do
        post("#{bad_url}/users").should_not route_to("users#create")
      end

      it "routes to #destroy" do
        delete("#{bad_url}/users/1").should_not route_to("users#destroy", id: "1")
      end
    end

  end
end
