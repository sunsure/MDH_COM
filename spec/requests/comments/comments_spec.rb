require 'spec_helper'

describe "Comments" do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    @article = FactoryGirl.create(:article, user: @user)
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"
  end

  describe "visiting an existing article" do
    it "has a link to create a new comment" do
      visit article_path(@article.to_param)
      page.should have_selector("a#new_comment_link")
    end
  end

  describe "creating a NEW comment on an article" do
    describe "with valid parameters" do
      it "creates a new comment", js: true do
        lambda do
          visit article_path(@article.to_param)
          click_link 'Add Comment'
          fill_in "comment_content", with: "Good News Everyone, I just made a comment."
          fill_in "comment_title", with: "Hey, it's a title!"
          click_button "Comment"
          current_path.should eq(article_path(@article.to_param))
          page.should have_content("Thanks for the comment!")
        end.should change(Comment, :count).by(1)
      end
    end

    describe "with invalid parameters" do
      it "doesn't create a new comment", js: true do
        lambda do
          visit article_path(@article.to_param)
          click_link 'Add Comment'
          fill_in "comment_title", with: ''
          fill_in "comment_content", with: ''
          click_button "Comment"
          current_path.should eq(article_path(@article.to_param))
          page.should have_content("Sorry, we weren't able to save your comment.")
        end.should_not change(Comment, :count).by(1)
      end
    end
  end

  describe "EDIT an existing comment" do
    describe "with VALID parameters" do
      before(:each) do
        @comment = FactoryGirl.create(:comment, article_id: @article.id)
      end
      it "updates it without problems", js: true do
        # make a new comment to edit
        visit article_path(@article.to_param)
        edit_button = page.find("a[href='#{edit_article_comment_path(@article.to_param, @comment.id)}']")
        edit_button.click
        page.should have_selector("form#edit_comment")
        fill_in "comment_title", with: 'hey its a new comment title'
        fill_in "comment_content", with: 'hey its an edited comment'
        click_button 'Comment'
        page.should have_content "Thanks for editing your comment!"
      end
    end

    describe "with INVALID parameters" do
      before(:each) do
        @comment = FactoryGirl.create(:comment, article_id: @article.id)
      end
      it "doesnt update when the title is blank", js: true do
        visit article_path(@article.to_param)
        edit_button = page.find("a[href='#{edit_article_comment_path(@article.to_param, @comment.id)}']")
        edit_button.click
        page.should have_selector("form#edit_comment")
        fill_in "comment_title", with: ''
        click_button 'Comment'
        page.should have_content "Sorry, we weren't able to update your comment."
        page.should have_content "can't be blank"
      end

      it "doesnt update when the content is blank", js: true do
        visit article_path(@article.to_param)
        edit_button = page.find("a[href='#{edit_article_comment_path(@article.to_param, @comment.id)}']")
        edit_button.click
        page.should have_selector("form#edit_comment")
        fill_in "comment_content", with: ''
        click_button 'Comment'
        page.should have_content "Sorry, we weren't able to update your comment."
        page.should have_content "can't be blank"
      end
    end
  end

  describe "REPLYing to an exisiting comment" do
    describe "with valid parameters" do
      before(:each) do
        @parent_comment = FactoryGirl.create(:comment, article_id: @article.id)
      end

      it "replies to the parent comment", js: true do
        # do it
        visit article_path(@article.to_param)
        reply_button = page.find("a[href='#{reply_article_comment_path(@article.to_param, @parent_comment.id)}']")
        reply_button.click
        page.should have_selector("form#reply_comment")
        fill_in "comment_title", with: 'hey its a new comment title'
        fill_in "comment_content", with: 'hey its an edited comment'
        click_button 'Comment'
        page.should have_content "Thanks for the reply!"
      end
    end

    describe "with INVALID parameters" do
      before(:each) do
        @parent_comment = FactoryGirl.create(:comment, article_id: @article.id)
      end
      it "doesnt reply if the title is blank", js: true do
        visit article_path(@article.to_param)
        reply_button = page.find("a[href='#{reply_article_comment_path(@article.to_param, @parent_comment.id)}']")
        reply_button.click
        page.should have_selector("form#reply_comment")
        fill_in "comment_title", with: ''
        click_button 'Comment'
        page.should have_content "Sorry, we weren't able to save your reply."
        page.should have_content "can't be blank"
      end

      it "doesnt reply if the content is blank", js: true do
        visit article_path(@article.to_param)
        reply_button = page.find("a[href='#{reply_article_comment_path(@article.to_param, @parent_comment.id)}']")
        reply_button.click
        page.should have_selector("form#reply_comment")
        fill_in "comment_content", with: ''
        click_button 'Comment'
        page.should have_content "Sorry, we weren't able to save your reply."
        page.should have_content "can't be blank"
      end
    end
  end
end
