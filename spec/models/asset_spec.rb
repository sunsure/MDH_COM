require 'spec_helper'

describe Asset do
  describe "concerning STI children" do
    describe "concerning images" do
      it "has a valid factory" do
        FactoryGirl.build(:image).should be_valid
      end
    end
  end
end
