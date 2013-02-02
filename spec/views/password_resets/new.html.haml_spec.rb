require 'spec_helper'

describe "password_resets/new.html.haml" do
  it "renders new password reset form" do
    render

    assert_select "p", text: "Enter your email address below and you will receive an email containing instructions on how to reset your password."

    assert_select "form", action: password_resets_path, method: "post" do
      assert_select "input#user_email", name: "user[email]"
      assert_select "input[type='submit']", name: "commit", value: "Send Reset Instructions"
    end
  end
end

