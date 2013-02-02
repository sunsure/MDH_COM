require 'spec_helper'

describe SessionsController do
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "GET 'unauthorized'" do
    it "show have a successful response" do
      get :unauthorized
      response.should be_success
    end
  end

  describe "POST 'create' with remember me" do
    it "should set the permanent cookies if remember set" do
      @user = FactoryGirl.create(:user)
      @user.update_attributes(confirmed_at: Time.zone.now, confirm_token: nil)
      @attr = {
        email: @user.email,
        password: @user.password,
        remember_me: 1,
      }

      @user.auth_token.should_not be_nil
      request.cookies[:auth_token].should be_nil
      post :create, @attr
      flash.now[:error].should_not =~ /invalid credentials/i
      response.should redirect_to(root_path)
      flash.now[:notice].should =~ /logged in successfully/i
      expires = response.headers["Set-Cookie"].split(";").last.split("=").last
      expires_on = Time.zone.parse(expires)
      expires_on.year.should eq(20.years.from_now.year)
      response.cookies["auth_token"].should eq(@user.auth_token)
    end
  end

  describe "POST 'create'" do
    before(:each) do
     @user = FactoryGirl.create(:user)
     @attr = { email: @user.email, password: @user.password }
     @user.update_attributes(confirm_token: nil, confirmed_at: Time.zone.now)
    end

    it "lets a valid user login" do
      @user.auth_token.should_not be_nil
      request.cookies[:auth_token].should be_nil
      post :create, @attr
      flash.now[:error].should_not =~ /invalid credentials/i
      response.should redirect_to(root_path)
      flash.now[:notice].should =~ /logged in successfully/i
      response.cookies["auth_token"].should eq(@user.auth_token)
    end

    it "lets the user logout" do
      login_as(@user)
      request.cookies[:auth_token].should eq(@user.auth_token)
      delete :destroy
      response.cookies[:auth_token].should be_nil
      response.should redirect_to(root_path)
    end
  end

end
