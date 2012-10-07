require 'spec_helper'

describe "articles/show" do
  before(:each) do
    @article = assign(:article, FactoryGirl.create(:article))
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(@article.title)
    rendered.should match(@article.content)
  end
end
