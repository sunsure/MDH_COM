require 'spec_helper'

describe "articles/new" do
  before(:each) do
    assign(:article, FactoryGirl.create(:article))
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    controller.stub!(:current_user, @user)
  end

  it "renders new article form" do
    render

    assert_select "form", action: articles_path, method: "post" do
      assert_select "input#article_title", name: "article[title]"
      assert_select "textarea#article_excerpt", name: "article[excerpt]"
      assert_select "textarea#article_content", name: "article[content]"
    end
  end
end
