require 'spec_helper'

describe "articles/index" do
  before(:each) do
    @first = FactoryGirl.create(:article)
    @second = FactoryGirl.create(:article)
    assign(:articles, Kaminari.paginate_array([@first, @second]).page)
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    controller.stub!(:current_user, @user)
  end

  it "renders a list of articles" do
    render

    assert_select ".art_title a", text: @first.title
    assert_select ".art_excerpt", text: @first.excerpt

    assert_select ".art_title a", text: @second.title
    assert_select ".art_excerpt", text: @second.excerpt
  end
end
