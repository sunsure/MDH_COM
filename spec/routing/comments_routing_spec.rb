require "spec_helper"

describe CommentsController do
  describe "routing" do
    let(:url) { "http://www.example.com" }
    let(:bad_url) { "http://www.example.com/admin" }

    describe "success" do
      it "routes to #new" do
        get("#{url}/articles/1/comments/new").should route_to("comments#new", article_id: "1")
      end

      it "routes to #edit" do
        get("#{url}/articles/1/comments/1/edit").should route_to("comments#edit", article_id: "1", id: "1")
      end

      it "routes to #create" do
        post("#{url}/articles/1/comments").should route_to("comments#create", article_id: "1")
      end

      it "routes to #update" do
        put("#{url}/articles/1/comments/1").should route_to("comments#update", article_id: "1", id: "1")
      end

      it "routes to #destroy" do
        delete("#{url}/articles/1/comments/1").should route_to("comments#destroy", article_id: "1", id: "1")
      end
    end

    describe "failure" do
      it "should not route to #new" do
        get("#{bad_url}/articles/1/comments/new").should_not route_to("comments#new", article_id: "1")
      end

      it "should not route to #edit" do
        get("#{bad_url}/articles/1/comments/1/edit").should_not route_to("comments#edit", article_id: "1", id: "1")
      end

      it "should not route to #create" do
        post("#{bad_url}/articles/1/comments").should_not route_to("comments#create", article_id: "1")
      end

      it "should not route to #update" do
        put("#{bad_url}/articles/1/comments/1").should_not route_to("comments#update", article_id: "1", id: "1")
      end

      it "should not route to #destroy" do
        delete("#{bad_url}/articles/1/comments/1").should_not route_to("comments#destroy", article_id: "1", id: "1")
      end
    end

  end
end
