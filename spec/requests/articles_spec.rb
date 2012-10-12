require 'spec_helper'

describe "Articles" do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"
    @article = FactoryGirl.create(:article, user: @user)
  end

  describe "visiting the index" do
    it "should have a header" do
      visit articles_path
      page.should have_selector('h3', content: "Listing Articles")
    end

    it "should have a new article button" do
      visit articles_path
      page.find_link('New Article')[:href].should == new_article_path
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

  describe "creating a NEW article" do
    describe "with valid parameters" do
      it "creates a new article successfully" do
        lambda do
          visit new_article_path
          fill_in "article_title", with: "How to be l33t"
          fill_in "article_content", with: "you gotta be me!"
          find(:css, "#article_publish").set(true)
          click_button "Create Article"
          page.should have_content("Article was created successfully.")
          current_path.should eq(article_path(Article.last))
        end.should change(Article, :count).by(1)
      end
    end

    describe "with invalid parameters" do
      it "should not create an article if title is blank" do
        lambda do
          visit new_article_path
          fill_in "article_title", with: ""
          fill_in "article_content", with: "you gotta be me!"
          find(:css, "#article_publish").set(true)
          click_button "Create Article"
          page.should have_content("can't be blank")
          page.should have_content("Failed to create article!")
          current_path.should eq(articles_path)
        end.should_not change(Article, :count).by(1)
      end

      it "should not create an article if content is blank" do
        lambda do
          visit new_article_path
          fill_in "article_title", with: "How to be l33t"
          fill_in "article_content", with: ""
          find(:css, "#article_publish").set(true)
          click_button "Create Article"
          page.should have_content("can't be blank")
          page.should have_content("Failed to create article!")
          current_path.should eq(articles_path)
        end.should_not change(Article, :count).by(1)
      end

    end
  end

  describe "UPDATE an exisitng article" do
    describe "with valid parameters" do
      it "should update the article" do
        visit edit_article_path(@article)
        fill_in "article_title", with: "How to be l33t"
        fill_in "article_content", with: "you gotta be me!"
        find(:css, "#article_publish").set(true)
        click_button "Update Article"
        page.should have_content("Article was updated successfully.")
        current_path.should eq(articles_path)
      end
    end

    describe "with invalid parameters" do
      it "should not update the article if the title is blank" do
        visit edit_article_path(@article)
        fill_in "article_title", with: ""
        fill_in "article_content", with: "you gotta be me!"
        find(:css, "#article_publish").set(true)
        click_button "Update Article"
        page.should have_content("can't be blank")
        page.should have_content("Failed to update article!")
        current_path.should eq(article_path(@article))
      end

      it "should not update the article if the content is blank" do
        visit edit_article_path(@article)
        fill_in "article_title", with: "How to be l33t"
        fill_in "article_content", with: ""
        find(:css, "#article_publish").set(true)
        click_button "Update Article"
        page.should have_content("can't be blank")
        page.should have_content("Failed to update article!")
        current_path.should eq(article_path(@article))
      end
    end
  end

  describe "DESTROY'ing a article" do
    it "should destroy the specified article" do
      lambda do
        visit articles_path
        click_link "Destroy"
      end.should change(Article, :count).by(-1)
    end
  end
end
