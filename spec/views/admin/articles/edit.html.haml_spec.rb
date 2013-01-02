require 'spec_helper'

describe "admin/articles/edit" do
  before(:each) do
    assign(:article, FactoryGirl.create(:article))
    stub_current_user(:can_can_controller)
  end

  it "renders the edit article form" do
    render

    assert_select "form", action: articles_path(@article), method: "post" do
      assert_select "input#article_title", name: "article[title]"
      assert_select "textarea#article_excerpt", name: "article[excerpt]"
      assert_select "textarea#article_content", name: "article[content]"
      assert_select "input#article_permalink", name: "article[permalink]"
    end
  end
end
