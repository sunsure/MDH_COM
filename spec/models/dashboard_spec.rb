require 'spec_helper'

describe Dashboard do

  describe "concerning dashboard boxes" do
    before(:each) do
      @user = FactoryGirl.create(:user_with_roles, with_roles: ["commenter"])
    end
    it "has dashboard boxes for the user" do
      Dashboard.boxes_for(@user).should eq(
        [
          {:title=>"My Comments", :link=>[:comments, :my], :content=>"See my recent comments", :permission=>[:create, Comment]},
          {:title=>"My Profile", :link=>[:edit, :my, :profile], :content=>"Customize my profile", :permission=>[:edit, @user]}
        ]
      )

    end
  end
end
