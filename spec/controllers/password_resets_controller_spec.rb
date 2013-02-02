require 'spec_helper'

describe PasswordResetsController do

  describe "GET 'new'" do
    it "should return http success" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create" do
    describe "with VALID params" do
      before(:each) do
        @user = FactoryGirl.create(:user, email: "foo-1337@notexample.com", password_reset_sent_at: Time.zone.now, password_reset_token: "12345")
        @user.update_attributes(confirmed_at: Time.zone.now, confirm_token: nil)
        @user.confirmed?.should eq(true)
      end

      it "sends a reset email" do
        expect {
          post :create, user: { email: @user.email }
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    describe "with INVALID params" do
      before(:each) do
        @user = FactoryGirl.create(:user, email: "foo-1337@example.com", password_reset_sent_at: Time.zone.now, password_reset_token: "12345")
        @user.update_attributes(confirmed_at: Time.zone.now, confirm_token: nil)
        @user.confirmed?.should eq(true)
      end

      it "does not send the reset email when example.com" do
        expect {
          post :create, user: { email: @user.email }
        }.to_not change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @user = FactoryGirl.create(:user, email: "foo-1337@notexample.com", password_reset_sent_at: Time.zone.now, password_reset_token: "12345")
      @user.update_attributes(confirmed_at: Time.zone.now, confirm_token: nil)
      @user.confirmed?.should eq(true)
    end

    it "returns http success" do
      get :edit, id: @user.password_reset_token
      response.should be_success
    end

    it "finds the right user as @user" do
      get :edit, id: @user.password_reset_token
      assigns(:user).should eq(@user)
    end
  end

  describe "PUT update" do
    before(:each) do
      @user = FactoryGirl.create(:user, email: "foo-1337@notexample.com", password_reset_sent_at: Time.zone.now, password_reset_token: "12345")
      @user.update_attributes(confirmed_at: Time.zone.now, confirm_token: nil)
      @user.confirmed?.should eq(true)
    end

    describe "with valid params" do
      it "updates the users password" do
        put :update, id: @user.password_reset_token, user: { password: "bada55", password_confirmation: "bada55" }
        assigns(:user).should eq(@user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        put :update, id: @user.password_reset_token, user: { password: "", password_confirmation: "bada55" }
        assigns(:user).should eq(@user)
      end
    end
  end

end
