require 'spec_helper'

describe "articles/show" do
  describe "with a logged in user" do
    before(:each) do
      @article = assign(:article, FactoryGirl.create(:article))
      @comment = assign(:comment, FactoryGirl.create(:comment))
      @comments = assign(:comments, [FactoryGirl.create(:comment)])
      stub_current_user([:view, :can_can_controller])
    end

    it "renders attributes in <p>" do
      render

      rendered.should match(@article.title)
      rendered.should match(@article.excerpt)
      rendered.should match(@article.content)

      assert_select "fieldset legend", text: "Comments"
      assert_select "fieldset p", text: "Leave your comments below."
      assert_select "a#new_comment_link", text: "Add Comment"
    end
  end

  describe "with a logged out user" do
    before(:each) do
      @article = assign(:article, FactoryGirl.create(:article))
      @comments = assign(:comments, [FactoryGirl.create(:comment)])
      stub_current_user([:view, :can_can_controller], {as_nil: true})
    end

    it "tells them to login to comment" do
      render
      assert_select "fieldset p", text: "Login or register to comment on this article."
    end
  end

end
