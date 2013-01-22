require 'spec_helper'

describe Comment do
  describe "concernins validations and factories" do
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
end
