require 'spec_helper'

describe "admin/articles/new" do
  before(:each) do
    assign(:article, FactoryGirl.create(:article))
    stub_current_user(:can_can_controller)
  end

  it "renders new article form" do
    render

    assert_select "form", action: articles_path, method: "post" do
      assert_select "input#article_title", name: "article[title]"
      assert_select "textarea#article_excerpt", name: "article[excerpt]"
      assert_select "input#article_permalink", name: "article[permalink]"
      assert_select "textarea#article_content", name: "article[content]"
    end
  end
end
