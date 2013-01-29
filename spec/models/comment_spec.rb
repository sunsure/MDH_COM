require 'spec_helper'

describe Comment do
  describe "concerning validations and factories" do
    it "should have a valid factory" do
      FactoryGirl.build(:comment).should be_valid
    end

    describe "with VALID parameters" do
      it "should be valid with a title" do
        FactoryGirl.build(:comment, content: 'content', title: "Foobar").should be_valid
      end

      it "should be valid with content" do
        FactoryGirl.build(:comment, content: 'content', title: "Foobar").should be_valid
      end

      it "should be able to be nested" do
        parent = FactoryGirl.create(:comment)
        FactoryGirl.build(:comment, content: 'content', title: "Foobar", parent_id: parent.id).should be_valid
      end
    end

    describe "with INVALID parameters" do
      it "should require content" do
        FactoryGirl.build(:comment, content: 'content', title: "").should_not be_valid
      end

      it "should require a title" do
        FactoryGirl.build(:comment, content: '', title: "Foobar").should_not be_valid
      end
    end
  end

  describe "concerning PUBLIC methods" do
    before(:each) do
      @comment = FactoryGirl.create(:comment)
    end

    it "knows the user_name" do
      @comment.user_name.should eq(@comment.user.name)
    end
  end

  describe "concerning optimization tricks" do
    before(:each) do
      @article = FactoryGirl.create(:article)
    end

    it "should update the counter cache when creating a new comment" do
      @article.comments_count.should eq(0)
      @comment = FactoryGirl.build(:comment, article: @article)
      @comment.article.should eq(@article)
      @comment.save
      @article.reload.comments_count.should eq(1)
    end

    it "should update the counter cache when deleting a comment" do
      @comment = FactoryGirl.build(:comment, article: @article)
      @comment.save
      @article.reload.comments_count.should eq(1)
      @comment.article.should eq(@article)
      @comment.destroy
      @article.reload.comments_count.should eq(0)
    end
  end
end
