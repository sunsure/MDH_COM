require 'spec_helper'

describe "Articles" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @article = FactoryGirl.create(:article, user: @user)
    simulate_login(@user, true)
  end

  describe "visiting the index" do
    it "should have a header" do
      visit articles_url
      page.should have_selector('h3', text: "Listing Articles")
    end
  end

  describe "showing an article" do
    it "should have the right title" do
      visit article_path(@article)
      page.should have_selector("head title", text: @article.title, count: 1)
      page.should have_selector("h3", text: "#{@article.title}")
    end
  end

end
