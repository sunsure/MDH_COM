require "spec_helper"

describe Admin::UsersController do
  describe "routing" do
    let(:url)     { "http://www.example.com/admin" }
    let(:bad_url) { "http://www.example.com" }

    describe "success" do
      # The Admin controller
      it "routes to #index" do
        get("#{url}/users").should route_to("admin/users#index")
      end

      it "routes to #new" do
        get("#{url}/users/new").should route_to("admin/users#new")
      end

      it "routes to #show" do
        get("#{url}/users/1").should route_to("admin/users#show", id: "1")
      end

      it "routes to #edit" do
        get("#{url}/users/1/edit").should route_to("admin/users#edit", id: "1")
      end

      it "routes to #create" do
        post("#{url}/users").should route_to("admin/users#create")
      end

      it "routes to #update" do
        put("#{url}/users/1").should route_to("admin/users#update", id: "1")
      end

      it "routes to #destroy" do
        delete("#{url}/users/1").should route_to("admin/users#destroy", id: "1")
      end
    end

    describe "failure" do
      # The regular controller shouldn't route to the Admin controller
      it "doesn't route to #index" do
        get("#{bad_url}/users").should_not route_to("admin/users#index")
      end

      it "doesn't route to #new" do
        get("#{bad_url}/users/register").should_not route_to("admin/users#new")
      end

      it "doesn't route to #show" do
        get("#{bad_url}/users/1").should_not route_to("admin/users#show", id: "1")
      end

      it "doesn't route to #edit" do
        get("#{bad_url}/users/1/edit").should_not route_to("admin/users#edit", id: "1")
      end

      it "doesn't route to #create" do
        post("#{bad_url}/users").should_not route_to("admin/users#create")
      end

      it "doesn't route to #update" do
        put("#{bad_url}/users/1").should_not route_to("admin/users#update", id: "1")
      end

      it "doesn't route to #destroy" do
        delete("#{bad_url}/users/1").should_not route_to("admin/users#destroy", id: "1")
      end
    end
  end
end
