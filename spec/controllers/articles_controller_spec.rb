require 'spec_helper'

describe ArticlesController do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    login_as(@user)

    @article = FactoryGirl.create(:article, user_id: @user.id)
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "returns HTTP success" do
      get :index
      response.should be_success
    end

    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end

    it "assigns all articles in the variable" do
      get :index
      assigns(:articles).should eq(Article.all)
    end
  end

  describe "GET show" do
    it "finds the right article" do
      get :show, {id: @article.id}
      assigns(:article).should eq(@article)
    end

    it "should render the show template" do
      get :show, {id: @article.id}
      response.should render_template(:show)
    end

    it "should return HTTP success" do
      get :show, {id: @article.id}
      response.should be_success
    end
  end

end
