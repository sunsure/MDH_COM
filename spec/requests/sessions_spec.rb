require 'spec_helper'

describe "SessionsController" do
  let(:user) { FactoryGirl.create(:user) }

  it "lets a person login" do
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Login"
    current_path.should eq(root_path)
  end

  it "lets them login with remember me" do
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    find(:css, "#remember_me").set(true)
    click_button "Login"
    current_path.should eq(root_path)
  end

  it "doesn't let a person login with bad credentials" do
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: "this is not my password"
    click_button "Login"
    current_path.should eq(login_path)
  end
end

