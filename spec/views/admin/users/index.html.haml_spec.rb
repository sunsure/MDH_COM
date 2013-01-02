require 'spec_helper'

describe "admin/users/index" do
  before(:each) do
    @first = FactoryGirl.create(:user)
    @second = FactoryGirl.create(:user)
    assign(:users, [@first, @second])
    stub_current_user(:both)
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: @first.last_name.to_s
    assert_select "tr>td", text: @first.first_name.to_s
    assert_select "tr>td", text: @first.email.to_s
    assert_select "tr>td", text: l(@first.created_at, format: :short)

    assert_select "tr>td", text: @second.last_name.to_s
    assert_select "tr>td", text: @second.first_name.to_s
    assert_select "tr>td", text: @second.email.to_s
    assert_select "tr>td", text: l(@second.created_at, format: :short)
  end
end
