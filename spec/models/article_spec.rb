require 'spec_helper'

describe Article do
  describe "concerning validations and factories" do
    it "should have a valid factory" do
      FactoryGirl.build(:article).should be_valid
    end

    it "should set the published_at automatically" do
    end

    describe "with valid params" do
      it "should be valid with a title" do
      end

      it "should be valid with content" do
      end
    end

    describe "with invalid params" do
      it "should require a title" do
      end

      it "should require content" do
      end
    end
  end
end
