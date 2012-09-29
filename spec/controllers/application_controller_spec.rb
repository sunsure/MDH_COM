require 'spec_helper'

describe ApplicationController do
  before(:each) { @user = FactoryGirl.create(:user) }

  describe "concering current_user" do
    describe "with a valid current user" do
      it "finds the right user" do
        login_as(@user)
        @current_user = User.find_by_auth_token(@user.auth_token)
        controller.send(:current_user).should eq(@user)
      end
    end

    describe "with a invalid current user" do
      it "doesn't find any users" do
        @malicious_user = User.find_by_auth_token("12345")
        @malicious_user.should be_nil
        controller.send(:current_user).should_not eq(@user)
      end
    end
  end
end
