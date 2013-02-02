require "spec_helper"

describe PasswordResetsController do
  describe "routing" do
    let(:url) { "http://www.example.com" }
    let(:bad_url) { "http://www.example.com/admin" }

    describe "success" do
      it "routes to #new" do
        get("#{url}/reset/password/new").should route_to("password_resets#new")
      end

      it "routes to #edit" do
        get("#{url}/reset/password/1/edit").should route_to("password_resets#edit", id: "1")
      end

      it "routes to #create" do
        post("#{url}/reset/password").should route_to("password_resets#create")
      end

      it "routes to #update" do
        put("#{url}/reset/password/1").should route_to("password_resets#update", id: "1")
      end
    end

    describe "failure" do
      it "should not route to #new" do
        get("#{bad_url}/reset/password/new").should_not route_to("password_resets#new")
      end

      it "should not route to #edit" do
        get("#{bad_url}/reset/password/1/edit").should_not route_to("password_resets#edit", id: "1")
      end

      it "should not route to #create" do
        post("#{bad_url}/reset/password").should_not route_to("password_resets#create")
      end

      it "should not route to #update" do
        put("#{bad_url}/reset/password/1").should_not route_to("password_resets#update", id: "1")
      end
    end

  end
end
