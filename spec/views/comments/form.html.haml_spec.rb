require 'spec_helper'

describe "comments/_form.html.haml" do
  before(:each) do
    @article = FactoryGirl.create(:article)
    @comment = FactoryGirl.create(:comment, article_id: @article.id)
    assign(:article, @article)
    assign(:comment, @comment)
    stub_current_user([:can_can_controller])
  end

  it "renders the form" do
    render

    assert_select "form", action: new_article_comment_path(@article.to_param), method: 'post' do
      assert_select "input#comment_title"
      assert_select "textarea#comment_content"
      assert_select "input", name: 'commit'
      assert_select "a", id: "cancel_new_comment_link"
    end
  end

end
