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

  # TODO: test the search action

  describe "GET tags" do
    it "assigns all tagged articles as @articles" do
      @tagged_article = FactoryGirl.create(:article, tag_list: "foo, bar, baz, qux")
      get :tags, tag: "foo"
      assigns(:articles).should eq([@tagged_article])
    end

    it "returns HTTP success" do
      get :tags, tag: "foo"
      response.should be_success
    end

    it "renders the index template" do
      get :tags, tag: "foo"
      response.should render_template("tags")
    end

    it "should redirect to root if no tag is specified" do
      get :tags
      response.should redirect_to(root_url)
    end
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
      get :show, {id: @article.to_param}
      assigns(:article).should eq(@article)
    end

    it "should render the show template" do
      get :show, {id: @article.to_param}
      response.should render_template(:show)
    end

    it "should return HTTP success" do
      get :show, {id: @article.to_param}
      response.should be_success
    end
  end

end
