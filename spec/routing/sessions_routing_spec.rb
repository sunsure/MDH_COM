require "spec_helper"

describe SessionsController do
  describe "routing" do
    let(:url) { "http://www.example.com" }
    let(:bad_url) { "http://www.example.com/admin" }

    describe "success" do
      it "routes /login to sessions#new" do
        get("#{url}/login").should route_to("sessions#new")
      end

      it "routes /logout sessions#destroy" do
       get("#{url}/logout").should route_to("sessions#destroy")
      end

      it "routes to sessions#create" do
        post("#{url}/sessions").should route_to("sessions#create")
      end

      it "routes /unauthorized to sessions#unauthorized" do
        get("#{url}/unauthorized").should route_to("sessions#unauthorized")
      end
    end

    describe "failure" do
      it "does not route /login to admin/sessions#new" do
        get("#{bad_url}/login").should_not route_to("sessions#new")
      end

      it "does not route /logout admin/sessions#destroy" do
       get("#{bad_url}/logout").should_not route_to("sessions#destroy")
      end

      it "does not route to admin/sessions#create" do
        post("#{bad_url}/sessions").should_not route_to("sessions#create")
      end

      it "does not route /unauthorized to admin/sessions#unauthorized" do
        get("#{bad_url}/unauthorized").should_not route_to("sessions#unauthorized")
      end
    end

  end
end