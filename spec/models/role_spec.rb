require 'spec_helper'

describe Role do
  before(:each) do
    FactoryGirl.create(:role, name: "Administrator", key: "admin")
    FactoryGirl.create(:role, name: "user", key: "user")
  end

  it "ensures that all the roles were created" do
    [
      :admin,
      :user,
    ].each do |role|
      assert_not_nil Role.get(role).present?
    end
  end

  it "can get roles by their key" do
    r = Role.get(:admin)
    assert_equal "admin", r.key
  end

  describe "create valid" do
    before(:each) do
      @attr = FactoryGirl.attributes_for(:role)
    end

    it "should have a valid factory" do
      FactoryGirl.build(:role).should be_valid
    end

    it "should create a valid user with valid attributes" do
      Role.new(@attr).should be_valid
    end
  end

  describe "create invalid" do
    it "should not be valid without a key" do
      role = FactoryGirl.build(:role, key: "")
      role.should_not be_valid
      role.should have(1).error_on(:key)
    end

    it "should reject duplicate keys regardless of case" do
      FactoryGirl.create(:role, key: "original").should be_valid
      duplicate = FactoryGirl.build(:role, key: "ORIGINAL")
      duplicate.should_not be_valid
      duplicate.should have(1).error_on(:key)
    end

    it "should not be valid without a name" do
      role = FactoryGirl.build(:role, name: "")
      role.should_not be_valid
      role.should have(1).error_on(:name)
    end

    it "should reject duplicate names regardless of case" do
      FactoryGirl.create(:role, name: "original").should be_valid
      duplicate = FactoryGirl.build(:role, name: "ORIGINAL")
      duplicate.should_not be_valid
      duplicate.should have(1).error_on(:name)
    end
  end

end
