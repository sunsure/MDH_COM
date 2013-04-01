require 'spec_helper'

describe "sessions/unauthorized" do

  it "renders the confirm_account form" do
    render

    assert_select "h3", text: "Not Authorized"
  end
end
