require 'spec_helper'

describe User do
  describe "valid users" do
    it "has a valid factory" do
      FactoryGirl.build(:user).should be_valid
    end

    it "should be valid if matching passwords were supplied" do
      FactoryGirl.build(:user, password: "foobar", password_confirmation: "foobar").should be_valid
    end

    it "should accept accept properly formatted email addresses" do
      %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |valid_email_address|
        FactoryGirl.build(:user, email: valid_email_address).should be_valid
      end
    end

    it "should be valid with the email present" do
      FactoryGirl.build(:user, email: "foo@bar.com").should be_valid
    end
  end

  describe "invalid users" do
    it "should not be valid if the password is blank" do
      FactoryGirl.build(:user, password: "", password_confirmation: "").should_not be_valid
    end

    it "should not be valid if the passwords dont match" do
      FactoryGirl.build(:user, password: "foobar", password_confirmation: "raboof").should_not be_valid
    end

    it "should require the email to be present" do
      FactoryGirl.build(:user, email: "").should_not be_valid
    end

    it "should reject invalid email addresses" do
      FactoryGirl.build(:user, email: "foo").should_not be_valid
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.].each do |address|
        invalid = FactoryGirl.build(:user, email: address)
        invalid.should_not be_valid
      end
    end

    it "should reject duplicate emails" do
      FactoryGirl.create(:user, email: "foo@bar.com")
      FactoryGirl.build(:user, email: "foo@bar.com").should_not be_valid
    end

    it "should reject duplicate emails regardless of case" do
      FactoryGirl.create(:user, email: "foo@bar.com")
      FactoryGirl.build(:user, email: "FOO@BAR.COM").should_not be_valid
    end
  end

  describe "concerning PRIVATE methods" do
    it "should generate an auth token" do
      user = FactoryGirl.create(:user)
      user.auth_token.should_not be_nil
    end

    it "should generate a confirm token" do
      user = FactoryGirl.create(:user)
      user.confirm_token.should_not be_nil
    end

    it "should send a confirmation email" do
      expect {
        user = FactoryGirl.create(:user)
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "should default them to commenter if no other roles" do
      role = FactoryGirl.create(:role, key: :commenter, name: "Commenter")
      user = FactoryGirl.create(:user)
      user.roles.should include(Role.find_by_key(:commenter))
      user.is?(:commenter).should eq(true)
    end
  end

  describe "concerning PUBLIC methods" do
    it "is? should return the right value" do
      user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
      user.roles.should eq([Role.find_by_key(:admin)])
      user.is?(:admin).should eq(true)
      user.is?(:commenter).should eq(false)
    end
    it "should return the right name" do
      u = FactoryGirl.create(:user)
      u.name.should match "#{u.first_name} #{u.last_name}"
    end
  end
end
