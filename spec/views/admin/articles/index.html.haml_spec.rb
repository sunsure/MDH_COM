require 'spec_helper'

describe "admin/articles/index" do
  before(:each) do
    @first = FactoryGirl.create(:article)
    @second = FactoryGirl.create(:article)
    assign(:articles, Kaminari.paginate_array([@first, @second]).page)
    stub_current_user([:can_can_controller])
  end

  it "renders a list of articles" do
    render

    assert_select ".media-heading a", text: @first.title
    assert_select ".media-heading div.comments_count", text: "0 comments"
    assert_select ".excerpt", text: @first.excerpt

    assert_select ".media-heading a", text: @second.title
    assert_select ".media-heading div.comments_count", text: "0 comments"
    assert_select ".excerpt", text: @second.excerpt
  end
end
