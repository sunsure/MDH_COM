require 'spec_helper'

describe Article do
  describe "concerning PUBLIC methods" do
    before(:each) do
      @article = FactoryGirl.create(:article)
    end

    it "to_param should be the permalink" do
      @article.to_param.should eq(@article.permalink)
    end
  end

  describe "concerning validations and factories" do
    it "should have a valid factory" do
      FactoryGirl.build(:article).should be_valid
    end

    it "should set the published_at automatically" do
      FactoryGirl.build(:article, publish: "1").published_at.should_not be_nil
    end

    describe "with valid params" do
      it "should be valid with a title" do
        FactoryGirl.build(:article, title: "Foobar").should be_valid
      end

      it "should be valid with content" do
        FactoryGirl.build(:article, content: "Foobar").should be_valid
      end

      it "should parameterize the permalink" do
        article = FactoryGirl.create(:article, permalink: "this is a &^ bad permalink")
        article.permalink.should eq("this-is-a-bad-permalink")
      end

      it "should be valid with an excerpt" do
        FactoryGirl.build(:article, excerpt: "Foobar").should be_valid
      end
    end

    describe "with invalid params" do
      before(:each) do
        @article = FactoryGirl.create(:article)
      end

      it "should require a title" do
        FactoryGirl.build(:article, title: "").should_not be_valid
      end

      it "should require content" do
        FactoryGirl.build(:article, content: "").should_not be_valid
      end

      it "should require a permalink" do
        FactoryGirl.build(:article, permalink: "").should_not be_valid
      end

      it "should reject duplicate permalink" do
        FactoryGirl.build(:article, permalink: @article.permalink).should_not be_valid
      end

      it "should reject duplicate permalink regardless of case" do
        FactoryGirl.build(:article, permalink: @article.permalink.upcase).should_not be_valid
      end

      it "should not be valid without an excerpt" do
        FactoryGirl.build(:article, excerpt: "").should_not be_valid
      end
    end
  end

  describe "concerning nested models" do
    it "should accept nested images" do
      should accept_nested_attributes_for(:images).but_reject({ :attachment => nil })
    end
  end

  describe "concerning the Permalinker" do
    it "should parameterize the permalink" do
      Article.permalinker("this title has spaces").should eq("this-title-has-spaces")
    end
  end

  describe "concerning typeahead_search" do
    before(:each) do
      @article = FactoryGirl.create(:article)
    end

    it "should return articles that match ILIKE the title" do
      result = Article.typeahead_search(@article.title.first(3))
      result.should include(@article)
    end

    it "should map only the attributes the typeahead javascript needs" do
      expected = [{title: @article.title, published_at: I18n.l(@article.published_at, format: :short), permalink: @article.permalink}]
      Article.published.to_pretty_json.should eq(expected)
    end

    it "should have a to_pretty_json instance method" do
      expected = {title: @article.title, published_at: I18n.l(@article.published_at, format: :short), permalink: @article.permalink}
      @article.to_pretty_json.should eq(expected)
    end
  end

end
