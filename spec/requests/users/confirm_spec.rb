require 'spec_helper'

describe "users/confirm" do
  before(:each) do
    @user = FactoryGirl.create(:user, email: "user@notexample.com")
  end

  describe "with a VALID user confirm should" do
    it "should confirm if the user is found" do
      visit edit_confirm_path(@user.confirm_token)
      click_button "Confirm"
      current_path.should eq(login_path)
      page.should have_content("Thanks for confirming your email.")
    end

    it "allows the confirmation to be resent", js: true do
      expect {
        visit confirm_account_path(@user.auth_token)
        click_button "Resend Confirmation"
        page.should have_content("Confirmation email has been sent.")
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end

  describe "with and INVALID user confirm should" do
    it "should throw a 404 if not found" do
      expect {
        # not found
        visit edit_confirm_path("12345")
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
