require 'spec_helper'

describe "admin/articles/show" do
  before(:each) do
    @article = assign(:article, FactoryGirl.create(:article))
    stub_current_user([:can_can_controller])
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(@article.title)
    rendered.should match(@article.excerpt)
    rendered.should match(@article.content)
  end
end
