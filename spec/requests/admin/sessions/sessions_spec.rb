require 'spec_helper'

describe "Sessions" do
  let(:user) { FactoryGirl.create(:user_with_roles, with_roles: ["admin"]) }

  it "lets a person login" do
    Capybara.app_host = 'http://admin.lvh.me:3000'
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Login"
    current_path.should eq(root_path)
  end

  it "lets them login with remember me" do
    Capybara.app_host = 'http://admin.lvh.me:3000'
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    find(:css, "#remember_me").set(true)
    click_button "Login"
    current_path.should eq(root_path)
  end

  it "doesn't let a person login with bad credentials" do
    Capybara.app_host = 'http://admin.lvh.me:3000'
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: "this is not my password"
    click_button "Login"
    current_path.should eq(login_path)
  end
end

