require 'spec_helper'

describe "Users" do
  before(:each) do
    Capybara.app_host = 'http://admin.lvh.me:3000'
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"
  end

  describe "creating a NEW user" do
    describe "with valid parameters" do
      it "creates a new user successfully" do
        lambda do
          visit new_user_path
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create User"
          page.should have_content("User was created successfully.")
          current_path.should eq(user_path(User.last))
        end.should change(User, :count).by(1)
      end
    end

    describe "with invalid parameters" do
      it "should not create a User if email is blank" do
        lambda do
          visit new_user_path
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: ""
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create User"
          page.should have_content("can't be blank")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end

      it "should not create a User if password is blank" do
        lambda do
          visit new_user_path
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: ""
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create User"
          page.should have_content("doesn't match confirmation")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end

      it "should not create a User if password confirmation is blank" do
        lambda do
          visit new_user_path
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: ""
          click_button "Create User"
          page.should have_content("doesn't match confirmation")
          page.should have_content("can't be blank")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end
    end
  end

end
