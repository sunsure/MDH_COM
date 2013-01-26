require "spec_helper"

describe Users::ConfirmController do
  describe "routing" do
    it "routes to the confirm#create action" do
      post("/confirm").should route_to("users/confirm#create")
    end

    it "routes to the confirm#edit action" do
      get("/confirm/1/edit").should route_to("users/confirm#edit", id: "1")
    end

    it "routes to the confirm action" do
      put("/confirm/1").should route_to("users/confirm#update", id: "1")
    end
  end
end
