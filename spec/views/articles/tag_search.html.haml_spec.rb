require 'spec_helper'

describe "articles/tag_search" do
  before(:each) do
    @article = FactoryGirl.create(:article, tag_list: "foo, bar")
    @foo = ActsAsTaggableOn::Tag.where(name: 'foo').first
    assign(:tags, Kaminari.paginate_array([@foo]).page)
    stub_current_user([:view])
  end

  it "renders a tag" do
    render

    assert_select "td", text: @foo.name

  end
end
