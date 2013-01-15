require 'spec_helper'

describe "Comments" do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"
    @article = FactoryGirl.create(:article, user: @user)
  end

  describe "successfully destroying a comment" do
    it "makes the comment go away", js: true do
      comment = FactoryGirl.create(:comment, article: @article)
      visit admin_article_path(@article.to_param)

      page.should have_content(comment.content)
      page.find_link('Destroy')[:href].should == admin_article_comment_path(@article.to_param, comment)
      page.find_link('Destroy').click
      page.should_not have_content(comment.content)
      page.should have_content("Comment has been destroyed successfully.")
    end
  end

end

