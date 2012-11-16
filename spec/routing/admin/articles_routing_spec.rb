require "spec_helper"

describe Admin::ArticlesController do
  describe "routing" do
    let(:url) { "http://admin.example.com" }
    let(:bad_url) { "http://www.example.com" }

    describe "success" do
      # The Admin controller
      it "routes to #calendar" do
        get("#{url}/articles/calendar").should route_to("admin/articles#calendar")
      end

      it "routes to #index" do
        get("#{url}/articles").should route_to("admin/articles#index")
      end

      it "routes to #new" do
        get("#{url}/articles/new").should route_to("admin/articles#new")
      end

      it "routes to #show" do
        get("#{url}/articles/1").should route_to("admin/articles#show", id: "1")
      end

      it "routes to #edit" do
        get("#{url}/articles/1/edit").should route_to("admin/articles#edit", id: "1")
      end

      it "routes to #create" do
        post("#{url}/articles").should route_to("admin/articles#create")
      end

      it "routes to #update" do
        put("#{url}/articles/1").should route_to("admin/articles#update", id: "1")
      end

      it "routes to #destroy" do
        delete("#{url}/articles/1").should route_to("admin/articles#destroy", id: "1")
      end

      it "routes to the tags action" do
        get("#{url}/articles/tags").should route_to("admin/articles#tags")
      end

      it "routes to a specific tag" do
        get("#{url}/articles/tags/foobar").should route_to("admin/articles#tags", tag: "foobar")
      end
    end

    describe "failure" do
      # The regular controller shouldn't route to the Admin controller
      it "routes to #calendar" do
        get("#{bad_url}/articles/calendar").should_not route_to("admin/articles#calendar")
      end

      it "routes to #index" do
        get("#{bad_url}/articles").should_not route_to("admin/articles#index")
      end

      it "routes to #new" do
        get("#{bad_url}/articles/new").should_not route_to("admin/articles#new")
      end

      it "routes to #show" do
        get("#{bad_url}/articles/1").should_not route_to("admin/articles#show", id: "1")
      end

      it "routes to #edit" do
        get("#{bad_url}/articles/1/edit").should_not route_to("admin/articles#edit", id: "1")
      end

      it "routes to #create" do
        post("#{bad_url}/articles").should_not route_to("admin/articles#create")
      end

      it "routes to #update" do
        put("#{bad_url}/articles/1").should_not route_to("admin/articles#update", id: "1")
      end

      it "routes to #destroy" do
        delete("#{bad_url}/articles/1").should_not route_to("admin/articles#destroy", id: "1")
      end

      it "routes to the tags action" do
        get("#{bad_url}/articles/tags").should_not route_to("admin/articles#tags")
      end

      it "routes to a specific tag" do
        get("#{bad_url}/articles/tags/foobar").should_not route_to("admin/articles#tags", tag: "foobar")
      end
    end

  end
end
