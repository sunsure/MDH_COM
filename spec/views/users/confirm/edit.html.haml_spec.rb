require 'spec_helper'

describe "users/confirm/edit" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    assign(:user, @user)
  end

  it "renders the edit confirm form" do
    render

    assert_select "h3", text: "Confirm Email"

    assert_select "p", text: "Please confirm your account by clicking the button below."

    assert_select "form", action: confirm_path(@user.confirm_token), method: "put" do
      assert_select "input#user_email", name: "user[email]"
      assert_select "input[type=submit]", value: "Confirm"
    end
  end
end
