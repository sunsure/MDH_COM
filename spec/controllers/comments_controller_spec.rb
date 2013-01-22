require 'spec_helper'

describe CommentsController do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    login_as(@user)

    @article = FactoryGirl.create(:article, user_id: @user.id)
  end

  def valid_attributes
    FactoryGirl.attributes_for(:comment)
  end

  def invalid_attributes
    { content: '' }
  end

  def valid_session
    {}
  end


  describe "GET reply to an existing comment" do
    before(:each) do
      @parent_comment = FactoryGirl.create(:comment, article_id: @article.id)
    end
    it "assigns a new comment as @comment" do
      get :reply, article_id: @article.to_param, id: @parent_comment.id, comment: { parent_id: @parent_comment.id }, format: :js
      assigns(:comment).should be_a(Comment)
      response.should be_success
    end
  end

  describe "POST reply" do
    before(:each) do
      @comment = FactoryGirl.create(:comment, article_id: @article.id)
    end

    describe "with valid params" do
      it "creates a new nested Comment" do
        expect {
          post :reply, comment: valid_attributes, article_id: @article.to_param, id: @comment.id, format: :js
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly replied comment as @comment" do
        post :reply, comment: valid_attributes, id: @comment.id, article_id: @article.to_param, format: :js
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :reply, id: @comment.id, article_id: @article.to_param, comment: invalid_attributes, format: :js
        assigns(:comment).should be_a_new(Comment)
      end
    end
  end

  describe "GET new" do
    it "assigns a new comment as @comment" do
      get :new, article_id: @article.to_param, format: :js
      assigns(:comment).should be_a_new(Comment)
      response.should be_success
    end
  end

  describe "GET edit" do
    before(:each) do
      @comment = FactoryGirl.create(:comment, article_id: @article.id, user_id: @user.id)
    end

    it "should get the right comment" do
      get :edit, { article_id: @article.to_param, id: @comment.to_param }, format: :js
      assigns(:comment).should eq(@comment)
    end
  end

  describe "POST create" do
    describe "with valid params", js: true do
      it "creates a new Comment" do
        expect {
          post :create, comment: valid_attributes, article_id: @article.to_param, format: :js
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, comment: valid_attributes, article_id: @article.to_param, format: :js
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :create, article_id: @article.to_param, comment: invalid_attributes, format: :js
        assigns(:comment).should be_a_new(Comment)
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @comment = FactoryGirl.create(:comment, user_id: @user.id, article_id: @article.id)
    end
    describe "with valid params", js: true do
      it "updates the requested comment" do
        put :update, id: @comment.id, article_id: @article.to_param, comment: valid_attributes, format: :js
      end

      it "assigns the requested comment as @comment" do
        put :update, id: @comment.id, article_id: @article.to_param, comment: valid_attributes, format: :js
        assigns(:comment).should eq(@comment)
      end
    end

    describe "with invalid params", js: true do
      it "assigns the comment as @comment" do
        put :update, id: @comment.id, article_id: @article.to_param, comment: invalid_attributes, format: :js
        assigns(:comment).should eq(@comment)
      end
    end
  end

end
