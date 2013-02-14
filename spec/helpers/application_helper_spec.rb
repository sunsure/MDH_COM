require 'spec_helper'

describe ApplicationHelper do
  describe "concerning syntax highlighting" do
    it "shouldnt blow up with a garbage lexer" do
      expect { helper.to_markdown("```markdown\n  thisshouldfail\n```").inspect }.to_not raise_error
    end
  end

  describe "concerning markdown" do
    it "should parse the markdown" do
      helper.to_markdown("*emphasis*").should eq("<p><em>emphasis</em></p>\n")
      helper.to_markdown("[Link Text](http://www.google.com)").should eq("<p><a href=\"http://www.google.com\">Link Text</a></p>\n")
    end
  end

  describe "concerning the title method" do
    it "should make it a title" do
      helper.title("title stuff")
      helper.content_for(:title).should == "title stuff"
    end
  end

  describe "concerning the sidebar carousel" do
    it "shows up if its defined" do
      @show_sidebar_carousel = true
      helper.show_sidebar_carousel?.should eq(true)
    end

    it "hides if its not defined" do
      @show_sidebar_carousel = false
      helper.show_sidebar_carousel?.should eq(false)
    end
  end
end
