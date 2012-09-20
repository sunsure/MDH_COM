require 'spec_helper'

describe SessionsController do

  describe "successful login" do
    describe "GET :new" do
      it "returns http success" do
        get :new
        response.should be_success
      end

      it "should render the new template" do
        get :new
        response.should render_template(:new)
      end
    end

    it "should find the right user" do
      correct_user = User.find_by_email("test@example.com")
    end

    it "should find the right user regardless of case" do
    end

    it "should set the cookie" do
    end

    it "should redirect to the root url" do
    end
  end

  # TODO: test create and destroy methods here

end
