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
  end
end
