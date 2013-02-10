require 'spec_helper'

describe User do
  describe "concerning administrators" do
    # Can-Can Custom RSpec Matchers
    # https://github.com/ryanb/cancan/wiki/Testing-Abilities
    # @user.should have_ability(:create, for: Post.new)
    # @user.should have_ability([:create, :read], for: Post.new)
    # @user.should have_ability({create: true, read: false, update: false, destroy: true}, for: Post.new)
    before(:each) do
      @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    end

    it "should let them manage everything" do
      @user.should have_ability(:manage, for: :all)
    end
  end

  describe "concering commenters" do
    before(:each) do
      @commenter = FactoryGirl.create(:user_with_roles, with_roles: ["commenter"])
      @admin = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
      @user = FactoryGirl.create(:user_with_roles, with_roles: ["user"])
    end

    it "should let them read comments" do
      @commenter.should have_ability(:read, for: Comment.new)
    end

    it "should let them create a user with no roles" do
      @commenter.should have_ability(:create, for: User.new(role_ids: [Role.where(key: 'commenter').first.id]))
      @commenter.should_not have_ability(:create, for: User.new(role_ids: [Role.where(key: 'admin').first.id]))
      @commenter.should_not have_ability(:create, for: User.new(role_ids: [Role.where(key: 'user').first.id]))
    end

    it "should let them confirm their account" do
      @commenter.should have_ability(:confirm, for: @commenter)
      @commenter.should_not have_ability(:confirm, for: @admin)
      @commenter.should_not have_ability(:confirm, for: @user)
    end

    it "should let them like a comment" do
      @commenter.should have_ability(:like, for: Comment.new)
    end

    it "should let them reply to a comment" do
      @commenter.should have_ability([:new_reply, :reply], for: Comment.new)
    end

    it "lets them report comments" do
      @commenter.should have_ability(:report, for: Comment.new)
    end

    it "lets them create, edit, and update comments with their own id" do
      @commenter.should have_ability([:create, :edit, :update], for: Comment.new(user_id: @commenter.id))
    end

    it "should let them view and search published articles" do
      @commenter.should have_ability([:calendar, :read, :tag_search], for: Article.new(published_at: 1.day.ago))
    end

    it "should not let them see unpublished articles" do
      @commenter.should_not have_ability([:calendar, :read, :tag_search], for: Article.new(published_at: 1.day.from_now))
    end

    it "should let them edit their profile" do
      @commenter.should have_ability([:edit, :update], for: @commenter)
    end
  end

  describe "concerning nil users (the public at large)" do
    before(:each) do
      @user = FactoryGirl.build(:user)
      @user.roles.should eq([])
      @commenter = FactoryGirl.create(:user_with_roles, with_roles: ["commenter"])
      @admin = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
      @registered_user = FactoryGirl.create(:user_with_roles, with_roles: ["user"])
    end

    it "lets them view published articles" do
      @user.should have_ability([:calendar, :read, :tag_search], for: Article.new(published_at: 1.day.ago))
    end

    it "should not let them see unpublished articles" do
      @user.should_not have_ability([:calendar, :read, :tag_search], for: Article.new(published_at: 1.day.from_now))
    end

    it "should let them read comments" do
      @user.should have_ability(:read, for: Comment.new)
    end

    it "should let them create a user with no roles" do
      @user.should have_ability(:create, for: User.new(role_ids: [Role.where(key: 'commenter').first.id]))
      @user.should_not have_ability(:create, for: User.new(role_ids: [Role.where(key: 'admin').first.id]))
      @user.should_not have_ability(:create, for: User.new(role_ids: [Role.where(key: 'user').first.id]))
    end

    it "should let them confirm their account" do
      @user.should have_ability(:confirm, for: @user)
      @user.should_not have_ability(:confirm, for: @admin)
      @user.should_not have_ability(:confirm, for: @registered_user)
    end

    it "should not let them like a comment" do
      @user.should_not have_ability(:like, for: Comment.new)
    end

    it "should not let them reply to a comment" do
      @user.should_not have_ability([:new_reply, :reply], for: Comment.new)
    end

    it "doesnt let them report comments" do
      @user.should_not have_ability(:report, for: Comment.new)
    end

    it "doesnt let them create, edit, and update comments with their own id" do
      @user.should_not have_ability([:create, :edit, :update], for: Comment.new(user_id: @user.id))
    end
  end
end
