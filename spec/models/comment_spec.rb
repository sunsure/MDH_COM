require 'spec_helper'

describe Comment do
  describe "concernins validations and factories" do
    it "should have a valid factory" do
      FactoryGirl.build(:comment).should be_valid
    end
  end
end
