require 'spec_helper'

describe User do
  describe "valid users" do
    it "has a valid factory" do
      FactoryGirl.create(:user).should be_valid
    end
  end
  describe "invalid users" do
    it "validates that email is present" do
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
end
