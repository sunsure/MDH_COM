require 'spec_helper'

describe "admin/users/show" do
  before(:each) do
    stub_current_user(:both)
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
  end
end
