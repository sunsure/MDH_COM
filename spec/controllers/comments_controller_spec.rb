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

  def valid_session
    {}
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
    describe "with valid params" do
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

      it "redirects to the Article the comment belongs to" do
        post :create, comment: valid_attributes, article_id: @article.to_param, format: :js
      end
    end

    # describe "with invalid params" do
    #   it "assigns a newly created but unsaved article as @article" do
    #     post :create, {article: invalid_attributes}, valid_session
    #     assigns(:article).should be_a_new(Article)
    #   end

    #   it "re-renders the 'new' template" do
    #     post :create, article: invalid_attributes
    #     response.should render_template("new")
    #   end
    # end
  end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Comment" do
  #       expect {
  #         post :create, {:comment => valid_attributes}, valid_session
  #       }.to change(Comment, :count).by(1)
  #     end

  #     it "assigns a newly created comment as @comment" do
  #       post :create, {:comment => valid_attributes}, valid_session
  #       assigns(:comment).should be_a(Comment)
  #       assigns(:comment).should be_persisted
  #     end

  #     it "redirects to the created comment" do
  #       post :create, {:comment => valid_attributes}, valid_session
  #       response.should redirect_to(Comment.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved comment as @comment" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Comment.any_instance.stub(:save).and_return(false)
  #       post :create, {:comment => { "article" => "invalid value" }}, valid_session
  #       assigns(:comment).should be_a_new(Comment)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Comment.any_instance.stub(:save).and_return(false)
  #       post :create, {:comment => { "article" => "invalid value" }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested comment" do
  #       comment = Comment.create! valid_attributes
  #       # Assuming there are no other comments in the database, this
  #       # specifies that the Comment created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Comment.any_instance.should_receive(:update_attributes).with({ "article" => "" })
  #       put :update, {:id => comment.to_param, :comment => { "article" => "" }}, valid_session
  #     end

  #     it "assigns the requested comment as @comment" do
  #       comment = Comment.create! valid_attributes
  #       put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
  #       assigns(:comment).should eq(comment)
  #     end

  #     it "redirects to the comment" do
  #       comment = Comment.create! valid_attributes
  #       put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
  #       response.should redirect_to(comment)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the comment as @comment" do
  #       comment = Comment.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Comment.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => comment.to_param, :comment => { "article" => "invalid value" }}, valid_session
  #       assigns(:comment).should eq(comment)
  #     end

  #     it "re-renders the 'edit' template" do
  #       comment = Comment.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Comment.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => comment.to_param, :comment => { "article" => "invalid value" }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested comment" do
  #     comment = Comment.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => comment.to_param}, valid_session
  #     }.to change(Comment, :count).by(-1)
  #   end

  #   it "redirects to the comments list" do
  #     comment = Comment.create! valid_attributes
  #     delete :destroy, {:id => comment.to_param}, valid_session
  #     response.should redirect_to(comments_url)
  #   end
  # end

end
