require 'spec_helper'

describe "sessions/new" do

  it "renders the login form" do
    render

    assert_select "form", action: sessions_path, method: :post do
      assert_select "input#email", name: "user[email]"
      assert_select "input#password", name: "user[password]"
      assert_select "input[type='submit']", name: "commit", value: "Login"
    end
  end
end
