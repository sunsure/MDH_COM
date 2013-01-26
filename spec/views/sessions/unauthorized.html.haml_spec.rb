require 'spec_helper'

describe "sessions/unauthorized" do

  it "renders the confirm_account form" do
    render

    assert_select "p", text: "not authorized"
  end
end
