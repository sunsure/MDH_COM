require 'spec_helper'

describe "admin/users/edit" do
  before(:each) do
    stub_current_user([:can_can_controller])
  end

  it "renders the edit user form" do
    render

    assert_select "form", action: users_path, method: "post" do
      assert_select "input#user_first_name", name: "user[first_name]"
      assert_select "input#user_last_name", name: "user[last_name]"
      assert_select "input#user_email", name: "user[email]"
      assert_select "input#user_password", name: "user[password]"
      assert_select "input#user_password_confirmation", name: "user[password_confirmation]"
      assert_select "input#user_display_email_true", name: "user[display_email]"
      assert_select "input#user_display_email_false", name: "user[display_email]"
    end
  end
end
