require 'spec_helper'

describe "admin/articles/show" do
  before(:each) do
    @article = assign(:article, FactoryGirl.create(:article))
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    controller.stub!(:current_user, @user)
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(@article.title)
    rendered.should match(@article.excerpt)
    rendered.should match(@article.content)
  end
end
