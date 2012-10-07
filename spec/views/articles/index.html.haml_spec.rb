require 'spec_helper'

describe "articles/index" do
  before(:each) do
    @first = FactoryGirl.create(:article)
    @second = FactoryGirl.create(:article)
    assign(:articles, [@first, @second])
  end

  it "renders a list of articles" do
    render

    assert_select "tr>td", text: @first.title
    assert_select "tr>td", text: @first.content

    assert_select "tr>td", text: @second.title
    assert_select "tr>td", text: @second.content
  end
end
