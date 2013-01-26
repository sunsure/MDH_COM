require 'spec_helper'

describe "sessions/confirm_account" do

  it "renders the confirm_account form" do
    render

    assert_select "h1", text: "Account Confirmation"
    assert_select "p.lead", text: "Why am I seeing this page?"

    assert_select "form", action: confirm_create_path, method: :post do
      assert_select "input[type='submit']", name: "commit", value: "Resend Confirmation"
    end
  end
end
