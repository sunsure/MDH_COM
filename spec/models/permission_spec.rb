require 'spec_helper'

describe Permission do
  describe "concerning factory settings" do
    it "should have a valid factory" do
      FactoryGirl.build(:permission).should be_valid
    end
  end

  describe "creating an invalid" do
    it "should require a role ID" do
      user = FactoryGirl.create(:user)
      FactoryGirl.build(:permission, user: user, role: nil).should_not be_valid
    end
  end

  describe "concerning validations" do
    it "should represent the user and role" do
      role = FactoryGirl.create(:role)
      user = FactoryGirl.create(:user)
      permission = FactoryGirl.create(:permission, user: user, role: role)
      permission.should be_valid
    end

    it "should avoid duplicating permissions" do
      # i.e. if a user gets tagged as 'admin', the entry
      # should only appear once in the database.
      role = FactoryGirl.create(:role)
      user = FactoryGirl.create(:user)
      permission = FactoryGirl.create(:permission, user: user, role: role)
      permission.should be_valid
      invalid_permission = FactoryGirl.build(:permission, user: user, role: role)
      invalid_permission.should_not be_valid
    end
  end
end
