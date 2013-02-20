require "spec_helper"

describe Admin::IconsController do
  describe "routing" do
    let(:url) { "http://www.example.com/admin" }
    let(:bad_url) { "http://www.example.com" }

    describe "success" do
      # The Admin controller
      it "routes to admin/icons#destroy" do
        delete("#{url}/articles/2/icons/1").should route_to("admin/icons#destroy", article_id: '2', id: '1')
      end
    end
  end
end