require 'spec_helper'

describe "Sessions" do

  describe "with an CONFIRMED user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it "lets a person login" do
      simulate_login(@user, true)
      current_path.should eq(root_path)
    end

    it "lets them login with remember me" do
      simulate_login(@user, true, {remember_me: true})
      current_path.should eq(root_path)
    end

    it "doesn't let a person login with bad credentials" do
      simulate_login(@user, true, {failure: true, remember_me: true})
      current_path.should eq(login_path)
    end
  end

  describe "with an UNCONFIRMED user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it "doesnt let them login if not confirmed" do
      # dont let them login if they haven't confirmed their account
      simulate_login(@user, false)
      current_path.should eq(confirm_account_path(@user.auth_token))
    end
  end

end

