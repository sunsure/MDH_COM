require 'spec_helper'

describe "admin/users/show" do
  before(:each) do
    stub_current_user([:view, :can_can_controller])
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(@user.email)
    rendered.should match(@user.display_email? ? 'true' : 'false')
    rendered.should match(@user.first_name)
    rendered.should match(@user.last_name)
  end
end
