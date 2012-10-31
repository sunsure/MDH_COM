require 'spec_helper'

describe "Articles" do
  before(:each) do
    Capybara.app_host = 'http://www.lvh.me:3000'
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"
    @article = FactoryGirl.create(:article, user: @user)
  end

  describe "visiting the index" do
    it "should have a header" do
      visit articles_url
      page.should have_selector('h3', content: "Listing Articles")
    end
  end

  describe "showing an article" do
    it "should have the right title" do
      visit article_path(@article)
      within("head title") do
        page.should have_content("#{@article.title}")
      end
      page.should have_selector("h3", text: "#{@article.title}")
    end
  end

end
