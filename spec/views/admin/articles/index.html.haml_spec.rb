require 'spec_helper'

describe "admin/articles/index" do
  before(:each) do
    @first = FactoryGirl.create(:article)
    @second = FactoryGirl.create(:article)
    assign(:articles, [@first, @second])
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    controller.stub!(:current_user, @user)
  end

  it "renders a list of articles" do
    render

    assert_select ".art_title a", text: @first.title.titleize
    assert_select ".art_excerpt", text: @first.excerpt

    assert_select ".art_title a", text: @second.title.titleize
    assert_select ".art_excerpt", text: @second.excerpt
  end
end
