require 'spec_helper'

describe ArticlesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user)

    @article = FactoryGirl.create(:article, user_id: @user.id)
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
    it "should get the right article" do
      get :edit, { id: @article.id }
      assigns(:article).should eq(@article)
    end

    it "should return HTTP success" do
      get :edit, { id: @article.id }
      response.should be_success
    end

    it "should render the new template" do
      get :edit, { id: @article.id }
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
        response.should redirect_to(Article.last)
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
        response.should redirect_to(@article)
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
    it "destroys the requested article" do
      expect {
        delete :destroy, id: @article.to_param
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      delete :destroy, id: @article.to_param
      response.should redirect_to(articles_url)
    end
  end

end
