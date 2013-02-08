require "spec_helper"

describe Admin::ImagesController do
  describe "routing" do
    let(:url) { "http://www.example.com/admin" }
    let(:bad_url) { "http://www.example.com" }

    describe "success" do
      # The Admin controller
      it "routes to admin/images#destroy" do
        delete("#{url}/articles/2/images/1").should route_to("admin/images#destroy", article_id: '2', id: '1')
      end
    end
  end
end