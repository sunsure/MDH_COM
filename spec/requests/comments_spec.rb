require 'spec_helper'

describe "Comments" do
  before(:each) do
    Capybara.app_host = 'http://www.lvh.me:3000'
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"
    @article = FactoryGirl.create(:article, user: @user)
  end

  describe "visiting an existing article" do
    it "has a link to create a new comment" do
      visit article_path(@article)
      page.should have_selector("a#new_comment_link")
    end
  end

  # describe "creating a NEW comment on an article" do
  #   describe "with valid parameters" do
  #     it "creates a new comment" do
  #       lambda do
  #         visit article_path(@article)
  #         # click_link 'Add Comment'
  #         # fill_in "comment_content", with: "Good News Everyone, I just made a comment."
  #         # click_button "Comment"
  #         # page.should have_content("Thanks for the comment!")
  #         current_path.should eq(article_path(@article))
  #       end.should change(Comment, :count).by(1)
  #     end
  #   end

  #   describe "with invalid parameters" do
  #     it "doesn't create a new comment" do
  #     end
  #   end
  # end
end
