require 'spec_helper'

describe "admin/users/show" do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    view.stub(:current_user, @user)
    controller.stub!(:current_user, @user)
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
  end
end
