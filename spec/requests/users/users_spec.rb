require 'spec_helper'

describe "Users" do
  describe "creating a NEW user" do
    describe "with valid parameters" do
      it "creates a new user successfully" do
        lambda do
          visit register_url
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create Account"
          page.should have_content("Thanks for registering. You'll receive an email shortly asking you to verify your email address.")
          current_path.should eq(login_path)
        end.should change(User, :count).by(1)
      end

      it "should send a confirmation email" do
        expect {
          visit register_url
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@notexample.com"
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create Account"
          page.should have_content("Thanks for registering.")
          page.should have_content("Thanks for registering. You'll receive an email shortly asking you to verify your email address.")
          current_path.should eq(login_path)
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    describe "with invalid parameters" do
      it "should not create a User if email is blank" do
        lambda do
          visit register_url
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: ""
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create Account"
          page.should have_content("can't be blank")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end

      it "should not create a User if password is blank" do
        lambda do
          visit register_url
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: ""
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create Account"
          page.should have_content("doesn't match confirmation")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end

      it "should not create a User if password confirmation is blank" do
        lambda do
          visit register_url
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: ""
          click_button "Create Account"
          page.should have_content("doesn't match confirmation")
          page.should have_content("can't be blank")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end
    end
  end

  describe "UPDATE an exisitng user" do
    before(:each) do
      @user = FactoryGirl.create(:user_with_roles, with_roles: ["commenter"])
      simulate_login(@user, true)
    end
    describe "with valid parameters" do
      it "should update the user" do
        visit edit_my_profile_path
        fill_in "user_password", with: "foobar123"
        fill_in "user_password_confirmation", with: "foobar123"
        click_button "Update My Profile"
        page.should have_content("Your profile has been saved successfully.")
        current_path.should eq(dashboard_my_path)
      end
    end

    describe "with invalid parameters" do
      it "should not update the user if the email is blank" do
        visit edit_my_profile_path
        fill_in "user_email", with: ""
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
        click_button "Update My Profile"
        page.should have_content("can't be blank")
        current_path.should eq(my_profile_path)
      end

      it "should not update the user if the password is blank" do
        visit edit_my_profile_path
        fill_in "user_password", with: ""
        fill_in "user_password_confirmation", with: "foobar"
        click_button "Update My Profile"
        page.should have_content("doesn't match confirmation")
        current_path.should eq(my_profile_path)
      end

      it "should not update the user if the password confirmation is blank" do
        visit edit_my_profile_path
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: ""
        click_button "Update My Profile"
        # NOTE: the password field here doesn't persist because it's a password input
        # so we wont have the "can't be blank" message
        page.should have_content("doesn't match confirmation")
        current_path.should eq(my_profile_path)
      end
    end
  end

end
