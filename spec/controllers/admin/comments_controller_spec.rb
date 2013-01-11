require 'spec_helper'

describe Admin::CommentsController do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    login_as(@user)

    @article = FactoryGirl.create(:article, user_id: @user.id)
  end

  describe "DELETE destroy", js: true do
    before(:each) do
      @comment = FactoryGirl.create(:comment, user_id: @user.id, article_id: @article.id)
    end
    it "destroys the requested comment" do
      expect {
        delete :destroy, article_id: @article.to_param, id: @comment.id, format: :js
      }.to change(Comment, :count).by(-1)
    end
  end

end
