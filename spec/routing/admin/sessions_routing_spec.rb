require "spec_helper"

describe SessionsController do
  describe "routing" do
    let(:url) { "http://admin.example.com" }
    let(:bad_url) { "http://www.example.com" }

    describe "success" do
      it "routes /login to admin/sessions#new" do
        get("#{url}/login").should route_to("admin/sessions#new")
      end

      it "routes /logout admin/sessions#destroy" do
       get("#{url}/logout").should route_to("admin/sessions#destroy")
      end

      it "routes to admin/sessions#create" do
        post("#{url}/sessions").should route_to("admin/sessions#create")
      end

      it "routes /unauthorized to admin/sessions#unauthorized" do
        get("#{url}/unauthorized").should route_to("admin/sessions#unauthorized")
      end
    end

    describe "failure" do
      it "does not route /login to admin/sessions#new" do
        get("#{bad_url}/login").should_not route_to("admin/sessions#new")
      end

      it "does not route /logout admin/sessions#destroy" do
       get("#{bad_url}/logout").should_not route_to("admin/sessions#destroy")
      end

      it "does not route to admin/sessions#create" do
        post("#{bad_url}/sessions").should_not route_to("admin/sessions#create")
      end

      it "does not route /unauthorized to admin/sessions#unauthorized" do
        get("#{bad_url}/unauthorized").should_not route_to("admin/sessions#unauthorized")
      end
    end

  end
end