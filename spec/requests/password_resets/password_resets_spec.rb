require 'spec_helper'

describe "PasswordResets" do
  before(:each) do
    @user = FactoryGirl.create(:user, confirmed_at: Time.zone.now, confirm_token: nil)
  end

  describe "concerning creating a NEW password reset request" do
    describe "with VALID parameters" do
      it "creates a NEW password reset request" do
        visit new_password_reset_url
        page.should have_selector("head title", text: 'Reset My Password', count: 1)
        page.should have_selector("h3", text: "Reset My Password")
        page.should have_selector("p", text: "Enter your email address below and you will receive an email containing instructions on how to reset your password.")
        fill_in "user_email", with: @user.email
        click_button "Send Reset Instructions"
        current_path.should eq(login_path)
        page.should have_content("Instructions for resetting your password have been emailed to you.")
      end
    end
  end

  describe "concerning EDITing an existing password reset request" do
    before(:each) do
      @user = FactoryGirl.create(:user, password_reset_sent_at: Time.zone.now, password_reset_token: "12345")
      @user.update_attribute(:confirmed_at, Time.zone.now)
      @user.update_attribute(:confirm_token, nil)
      @user.confirmed?.should eq(true)
    end

    describe "with VALID parameters" do
      it "updates the users password" do
        # put in a new password
        visit edit_password_reset_url(id: "12345")
        fill_in "user_password", with: "bada55"
        fill_in "user_password_confirmation", with: "bada55"
        click_button "Reset Password"
        current_path.should eq(login_path)
        page.should have_content("Your password has been updated successfully.")
      end
    end

    describe "with INVALID parameters" do
      it "doesn't update if the passwords dont match" do
        visit edit_password_reset_url(id: "12345")
        fill_in "user_password", with: "bada55"
        fill_in "user_password_confirmation", with: "55adab"
        click_button "Reset Password"
        page.should have_content("doesn't match confirmation")
      end

      it "doesn't update if it's expired" do
        @user.update_attribute(:password_reset_sent_at, Time.zone.now - 3.hours)
        visit edit_password_reset_url(id: "12345")
        fill_in "user_password", with: "bada55"
        fill_in "user_password_confirmation", with: "bada55"
        click_button "Reset Password"
        current_path.should eq(login_path)
        page.should have_content("Password reset request has expired!")
      end
    end
  end
end