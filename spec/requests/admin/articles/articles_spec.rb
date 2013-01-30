require 'spec_helper'

describe "Articles" do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    @article = FactoryGirl.create(:article, user: @user)
    simulate_login(@user, true)
  end


  describe "visiting the calendar view" do
    it "should have a header" do
      visit calendar_admin_articles_path
      page.should have_selector('h3', text: 'Calendar')
    end

    it "should have a link to create a new article" do
      visit calendar_admin_articles_path
      page.find_link('New Article')[:href].should == new_admin_article_path
    end

    it "should have a link to list view" do
      visit calendar_admin_articles_path
      page.find_link('list')[:href].should == admin_articles_path
    end
  end

  describe "visiting the index" do
    it "should have a header" do
      visit admin_articles_path
      page.should have_selector('h3', text: "Listing Articles")
    end

    it "should have a new article button" do
      visit admin_articles_path
      page.find_link('New Article')[:href].should == new_admin_article_path
    end
  end

  describe "showing an article" do
    it "should have the right title" do
      visit admin_article_path(@article)
      page.should have_selector("head title", text: @article.title, count: 1)
      page.should have_selector("h3", text: "#{@article.title}")
    end
  end

  describe "creating a NEW article" do
    describe "with valid parameters" do
      it "creates a new article successfully" do
        lambda do
          visit new_admin_article_path
          fill_in "article_title", with: "How to be l33t"
          fill_in "article_content", with: "you gotta be me!"
          fill_in "article_permalink", with: "this is my permalink"
          fill_in "article_excerpt", with: "this is my excerpt"
          click_button "Create Article"
          page.should have_content("Article was created successfully.")
          current_path.should eq(admin_article_path(Article.first))
        end.should change(Article, :count).by(1)
      end
    end

    describe "with invalid parameters" do
      it "should not create an article if title is blank" do
        lambda do
          visit new_admin_article_path
          fill_in "article_title", with: ""
          fill_in "article_content", with: "you gotta be me!"
          fill_in "article_permalink", with: "this is my permalink"
          fill_in "article_excerpt", with: "this is my excerpt"
          click_button "Create Article"
          page.should have_content("can't be blank")
          page.should have_content("Failed to create article!")
          current_path.should eq(admin_articles_path)
        end.should_not change(Article, :count).by(1)
      end

      it "should not create an article if content is blank" do
        lambda do
          visit new_admin_article_path
          fill_in "article_title", with: "How to be l33t"
          fill_in "article_content", with: ""
          fill_in "article_permalink", with: "this is my permalink"
          fill_in "article_excerpt", with: "this is my excerpt"
          click_button "Create Article"
          page.should have_content("can't be blank")
          page.should have_content("Failed to create article!")
          current_path.should eq(admin_articles_path)
        end.should_not change(Article, :count).by(1)
      end

      it "should not create an article if permalink is blank" do
        lambda do
          visit new_admin_article_path
          fill_in "article_title", with: "How to be l33t"
          fill_in "article_content", with: "you gotta be me!"
          fill_in "article_permalink", with: ""
          fill_in "article_excerpt", with: "this is my excerpt"
          click_button "Create Article"
          page.should have_content("can't be blank")
          page.should have_content("Failed to create article!")
          current_path.should eq(admin_articles_path)
        end.should_not change(Article, :count).by(1)
      end

      it "should not create an article if excerpt is blank" do
        lambda do
          visit new_admin_article_path
          fill_in "article_title", with: "How to be l33t"
          fill_in "article_content", with: "you gotta be me!"
          fill_in "article_permalink", with: "this is my permalink"
          fill_in "article_excerpt", with: ""
          click_button "Create Article"
          page.should have_content("can't be blank")
          page.should have_content("Failed to create article!")
          current_path.should eq(admin_articles_path)
        end.should_not change(Article, :count).by(1)
      end

    end
  end

  describe "UPDATE an exisitng article" do
    describe "with valid parameters" do
      it "should update the article" do
        visit edit_admin_article_path(@article)
        fill_in "article_title", with: "How to be l33t"
        fill_in "article_content", with: "you gotta be me!"
        fill_in "article_permalink", with: "this is my permalink"
        fill_in "article_excerpt", with: "this is my excerpt"
        click_button "Update Article"
        page.should have_content("Article was updated successfully.")
        @article.should == Article.last
        current_path.should eq(admin_article_path(Article.last))
      end
    end

    describe "with invalid parameters" do
      it "should not update the article if the title is blank" do
        visit edit_admin_article_path(@article)
        fill_in "article_title", with: ""
        fill_in "article_content", with: "you gotta be me!"
        fill_in "article_permalink", with: "this is my permalink"
        fill_in "article_excerpt", with: "this is my excerpt"
        click_button "Update Article"
        page.should have_content("can't be blank")
        page.should have_content("Failed to update article!")
        current_path.should eq(admin_article_path(@article))
      end

      it "should not update the article if the content is blank" do
        visit edit_admin_article_path(@article)
        fill_in "article_title", with: "How to be l33t"
        fill_in "article_permalink", with: "this is my permalink"
        fill_in "article_content", with: ""
        fill_in "article_excerpt", with: "this is my excerpt"
        click_button "Update Article"
        page.should have_content("can't be blank")
        page.should have_content("Failed to update article!")
        current_path.should eq(admin_article_path(@article))
      end

      it "should not update the article if the permalink is blank" do
        visit edit_admin_article_path(@article)
        fill_in "article_title", with: "How to be l33t"
        fill_in "article_permalink", with: ""
        fill_in "article_content", with: "you gotta be me!"
        fill_in "article_excerpt", with: "this is my excerpt"
        click_button "Update Article"
        page.should have_content("can't be blank")
        page.should have_content("Failed to update article!")
        current_path.should eq(admin_article_path(@article))
      end

      it "should not update the article if the excerpt is blank" do
        visit edit_admin_article_path(@article)
        fill_in "article_title", with: "How to be l33t"
        fill_in "article_permalink", with: "this is"
        fill_in "article_content", with: "you gotta be me!"
        fill_in "article_excerpt", with: ""
        click_button "Update Article"
        page.should have_content("can't be blank")
        page.should have_content("Failed to update article!")
        current_path.should eq(admin_article_path(@article))
      end
    end
  end

  describe "DESTROY'ing a article" do
    it "should destroy the specified article (ajax)", format: :js do
      lambda do
        visit admin_articles_path
        click_link "Destroy"
      end.should change(Article, :count).by(-1)
    end

    it "should destroy the specified article" do
      lambda do
        visit admin_articles_path
        click_link "Destroy"
      end.should change(Article, :count).by(-1)
    end
  end
end
