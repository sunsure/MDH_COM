require 'spec_helper'

describe "password_resets/edit.html.haml" do
  before(:each) do
    @user = FactoryGirl.create(:user, password_reset_sent_at: Time.zone.now, password_reset_token: "12345")
    @user.update_attribute(:confirmed_at, Time.zone.now)
    @user.update_attribute(:confirm_token, nil)
    @user.confirmed?.should eq(true)
    assign(:user, @user)
  end
  it "renders edit password form" do
    render

    assert_select "form", action: password_reset_path(@user.password_reset_token), method: "put" do
      assert_select "input#user_password", name: "user[password]"
      assert_select "input#user_password_confirmation", name: "user[password_confirmation]"
      assert_select "input[type='submit']", name: "commit", value: "Reset Password"
    end
  end
end
