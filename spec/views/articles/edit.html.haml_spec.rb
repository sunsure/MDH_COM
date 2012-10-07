require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    assign(:article, FactoryGirl.create(:article))
  end

  it "renders the edit article form" do
    render

    assert_select "form", action: articles_path(@article), method: "post" do
      assert_select "input#article_title", name: "article[title]"
      assert_select "textarea#article_content", name: "article[content]"
    end
  end
end
