require 'spec_helper'

describe Users::ConfirmController do
  describe "GET 'edit'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm_token.should_not be_nil
      @user.confirmed_at.should be_nil
      @user.confirmed?.should eq(false)
    end
    it "should return http success" do
      get :edit, id: @user.confirm_token
      response.should be_success
    end
  end

  describe "POST 'create" do
    describe "with VALID params" do
      before(:each) do
        @user = FactoryGirl.create(:user, email: "foo-1337@notexample.com")
        @user.confirm_token.should_not be_nil
        @user.confirmed_at.should be_nil
        @user.confirmed?.should eq(false)
      end

      it "sends a confirmation email" do
        expect {
          post :create, auth_token: @user.auth_token, format: :js
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    describe "with INVALID params" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @user.confirm_token.should_not be_nil
        @user.confirmed_at.should be_nil
        @user.confirmed?.should eq(false)
      end

      it "does not send the confirmation email when the auth token is wrong" do
        expect {
          post :create, auth_token: 'not-my-auth-token', js: true
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @user = FactoryGirl.create(:user, email: "foo-1337@notexample.com")
      @user.confirm_token.should_not be_nil
      @user.confirmed_at.should be_nil
      @user.confirmed?.should eq(false)
    end

    describe "with valid params" do
      it "confirms the users account" do
        put :update, id: @user.confirm_token, user: { email: @user.email }
        assigns(:user).should eq(@user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        put :update, id: @user.confirm_token, user: { email: 'notmyemail@notexample.com' }
        assigns(:user).should eq(@user)
      end
    end
  end

end

