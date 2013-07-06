require "spec_helper"

describe ArticlesController do
  describe "routing" do
    let(:url) { "http://www.example.com" }
    let(:bad_url) { "http://www.example.com/admin" }

    describe "success" do
      # The regular controller
      it "routes to #calendar" do
        get("#{url}/articles/calendar").should route_to("articles#calendar")
      end

      it "routes to #index" do
        get("#{url}/articles").should route_to("articles#index")
      end

      it "routes to #show" do
        get("#{url}/articles/1").should route_to("articles#show", id: "1")
      end

      it "routes to the tags action" do
        get("#{url}/articles/tags").should route_to("articles#tags")
      end

      it "routes to a specific tag" do
        get("#{url}/articles/tags/foobar").should route_to("articles#tags", tag: "foobar")
      end

      it "routes to the tag search action" do
        get("#{url}/articles/taggings/search").should route_to("articles#tag_search")
      end

      it "routes to the typeahead search action" do
        get("#{url}/articles/typeahead_search").should route_to("articles#typeahead_search")
      end
    end

    describe "failure" do
      # The admin routes shouldn't route to the regular controller
      it "doesnt route to #calendar" do
        get("#{bad_url}/articles/calendar").should_not route_to("articles#calendar")
      end

      it "doesnt route to #index" do
        get("#{bad_url}/articles").should_not route_to("articles#index")
      end

      it "doesnt route to #new" do
        get("#{bad_url}/articles/new").should_not route_to("articles#new")
      end

      it "doesnt route to #show" do
        get("#{bad_url}/articles/1").should_not route_to("articles#show", id: "1")
      end

      it "doesnt route to #edit" do
        get("#{bad_url}/articles/1/edit").should_not route_to("articles#edit", id: "1")
      end

      it "doesnt route to #create" do
        post("#{bad_url}/articles").should_not route_to("articles#create")
      end

      it "doesnt route to #update" do
        put("#{bad_url}/articles/1").should_not route_to("articles#update", id: "1")
      end

      it "doesnt route to #destroy" do
        delete("#{bad_url}/articles/1").should_not route_to("articles#destroy", id: "1")
      end

      it "doesnt route to the tags action" do
        get("#{bad_url}/articles/tags").should_not route_to("articles#tags")
      end

      it "doesnt route to a specific tag" do
        get("#{bad_url}/articles/tags/foobar").should_not route_to("articles#tags", tag: "foobar")
      end

      it "doesnt route to the tag search action" do
        get("#{bad_url}/articles/taggings/search").should_not route_to("articles#tag_search")
      end

      it "doesnt route to the typeahead search action" do
        get("#{bad_url}/articles/typeahead_search").should_not route_to("articles#typeahead_search")
      end
    end

  end
end
