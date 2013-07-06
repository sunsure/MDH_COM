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

  describe "GET typeahead_search" do
    it "returns JSON data as a response" do
      get :typeahead_search, query: @article.title.first(3)
      response.should be_success
      assigns(:articles).should include(@article)
    end
  end

  describe "GET tag_search" do
    before(:each) do
      @tagged_article = FactoryGirl.create(:article, tag_list: "foo, bar, baz, qux")
    end

    it "can find a tag" do
      get :tag_search, query: "foo"
      assigns(:tags).should include(ActsAsTaggableOn::Tag.where(name: 'foo').first)
    end

    it "returns HTTP success" do
      get :tag_search, query: "foo"
      response.should be_success
    end

    it "renders the tag_search template" do
      get :tag_search, query: "foo"
      response.should render_template("tag_search")
    end
  end

  describe "GET calendar" do
    it "should get the correct articles by date" do
      get :calendar
      assigns(:articles).should eq(Article.published)
      assigns(:articles_by_date).should eq(Article.published.group_by { |a| a.published_at.to_date })
      assigns(:date).should eq(Time.zone.now.to_date)
    end

    it "should return HTTP success" do
      get :calendar
      response.should be_success
    end

    it "should render the calendar template" do
      get :calendar
      response.should render_template("calendar")
    end
  end

  describe "GET tags" do
    it "assigns all tagged articles as @articles" do
      @tagged_article = FactoryGirl.create(:article, tag_list: "foo, bar, baz, qux")
      @unpublished_tagged_article = FactoryGirl.create(:article, tag_list: "foo, bar, baz, qux", published_at: nil)
      get :tags, tag: "foo"
      assigns(:articles).should eq([@tagged_article])
      assigns(:articles_tag_counts).should_not be_nil
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

    it "shouldnt show articles that are not published yet" do
      get :tags, tag: 'foo'
      assigns(:articles).should_not include(@unpublished_tagged_article)
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
