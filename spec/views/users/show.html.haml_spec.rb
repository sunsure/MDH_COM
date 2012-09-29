require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
    view.stub(:current_user, @user)
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
  end
end
