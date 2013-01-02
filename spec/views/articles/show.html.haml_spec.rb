require 'spec_helper'

describe "articles/show" do
  describe "with a logged in user" do
    before(:each) do
      @article = assign(:article, FactoryGirl.create(:article))
      stub_current_user(:view)
    end

    it "renders attributes in <p>" do
      render

      rendered.should match(@article.title)
      rendered.should match(@article.excerpt)
      rendered.should match(@article.content)

      assert_select "fieldset#article_comments legend", text: "Comments"
      assert_select "fieldset#article_comments p", text: "Leave your comments below."

      assert_select "form", method: "post" do
        assert_select "#comment_content", name: "comment[content]"
      end
    end
  end

  describe "with a logged out user" do
    before(:each) do
      @article = assign(:article, FactoryGirl.create(:article))
      stub_current_user(:view, {as_nil: true})
    end

    it "tells them to login to comment" do
      render
      assert_select "fieldset#article_comments p", text: "Login or register to comment on this article."
    end
  end

end
