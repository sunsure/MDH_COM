require 'spec_helper'

describe SessionsController do

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

  # TODO: test create and destroy methods here

end
