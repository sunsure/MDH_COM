require 'spec_helper'

describe "articles/index" do
  before(:each) do
    @first = FactoryGirl.create(:article)
    @second = FactoryGirl.create(:article)
    assign(:articles, Kaminari.paginate_array([@first, @second]).page)
    stub_current_user([:view])
  end

  it "renders a list of articles" do
    render

    assert_select ".media-heading a", text: @first.title
    assert_select ".excerpt", text: @first.excerpt

    assert_select ".media-heading a", text: @second.title
    assert_select ".excerpt", text: @second.excerpt
  end
end
