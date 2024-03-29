require 'spec_helper'

describe Admin::ArticlesController do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    login_as(@user)
  end

  def valid_attributes
    FactoryGirl.attributes_for(:article)
  end

  def invalid_attributes
    {
      title: "",
      content: "",
      user: nil
    }
  end

  def valid_session
    {}
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
  end

  describe "GET index" do
    before(:each) do
      @article = FactoryGirl.create(:article, user_id: @user.id)
    end

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
    before(:each) do
      @article = FactoryGirl.create(:article, user_id: @user.id)
    end
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

  describe "GET new" do
    it "should setup @article as a new Article instance" do
      get :new
      assigns(:article).should be_a_new(Article)
    end

    it "should return HTTP success" do
      get :new
      response.should be_success
    end

    it "should render the new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "GET edit" do
    before(:each) do
      @article = FactoryGirl.create(:article, user_id: @user.id)
    end
    it "should get the right article" do
      get :edit, { id: @article.to_param }
      assigns(:article).should eq(@article)
    end

    it "should return HTTP success" do
      get :edit, { id: @article.to_param }
      response.should be_success
    end

    it "should render the edit template" do
      get :edit, { id: @article.to_param }
      response.should render_template(:edit)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Article" do
        expect {
          post :create, article: valid_attributes
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, article: valid_attributes
        assigns(:article).should be_a(Article)
        assigns(:article).should be_persisted
      end

      it "redirects to the created article" do
        post :create, article: valid_attributes
        response.should redirect_to(admin_article_path(Article.first))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved article as @article" do
        post :create, {article: invalid_attributes}, valid_session
        assigns(:article).should be_a_new(Article)
      end

      it "re-renders the 'new' template" do
        post :create, article: invalid_attributes
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @article = FactoryGirl.create(:article, user_id: @user.id)
    end
    describe "with valid params" do
      it "updates the requested article" do
        put :update, id: @article.to_param, article: valid_attributes
      end

      it "assigns the requested article as @article" do
        put :update, id: @article.to_param, article: valid_attributes
        assigns(:article).should eq(@article)
      end

      it "redirects to the article" do
        put :update, id: @article.to_param, article: valid_attributes
        response.should redirect_to(admin_article_path(Article.first))
      end
    end

    describe "with invalid params" do
      it "assigns the article as @article" do
        put :update, id: @article.to_param, article: invalid_attributes
        assigns(:article).should eq(@article)
      end

      it "re-renders the 'edit' template" do
        put :update, id: @article.to_param, article: invalid_attributes
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @article = FactoryGirl.create(:article, user_id: @user.id)
    end
    it "destroys the requested article" do
      expect {
        delete :destroy, id: @article.to_param
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      delete :destroy, id: @article.to_param
      response.should redirect_to(admin_articles_url)
    end
  end

  describe "POST permalinker" do
    it "sends back a parameterized permalink for automagic fun!" do
      post :permalinker, query: "^&this is _ - a BAD p3rmalink!()"
      response.body.should eq("this-is-_-a-bad-p3rmalink")
    end
  end

end
