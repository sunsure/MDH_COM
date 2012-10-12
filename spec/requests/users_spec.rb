require 'spec_helper'

describe "Users" do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"
  end

  describe "visiting the index" do
    it "should have a header" do
      visit users_path
      page.should have_selector('h3', content: "Listing Users")
    end

    it "should have a new user button" do
      visit users_path
      # Note: I'm leaving this here for future references
      page.find('a[href="/users/new"]')
      page.find_link('New User')[:href].should == new_user_path
      page.has_link?('New User', href: new_user_path)
    end
  end

  describe "showing a user" do
    it "should have the right title" do
      visit user_path(@user)
      within("head title") do
        page.should have_content("User : #{@user.name}")
      end
      page.should have_selector("h3", text: "User : #{@user.name}")
    end
  end

  describe "creating a NEW user" do
    describe "with valid parameters" do
      it "creates a new user successfully" do
        lambda do
          visit new_user_path
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create User"
          page.should have_content("User was created successfully.")
          current_path.should eq(user_path(User.last))
        end.should change(User, :count).by(1)
      end
    end

    describe "with invalid parameters" do
      it "should not create a User if email is blank" do
        lambda do
          visit new_user_path
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: ""
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create User"
          page.should have_content("can't be blank")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end

      it "should not create a User if password is blank" do
        lambda do
          visit new_user_path
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: ""
          fill_in "user_password_confirmation", with: "foobar"
          click_button "Create User"
          page.should have_content("doesn't match confirmation")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end

      it "should not create a User if password confirmation is blank" do
        lambda do
          visit new_user_path
          fill_in "user_first_name", with: "Mark"
          fill_in "user_last_name", with: "Holmberg"
          fill_in "user_email", with: "user@example.com"
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: ""
          click_button "Create User"
          page.should have_content("doesn't match confirmation")
          page.should have_content("can't be blank")
          current_path.should eq(users_path)
        end.should_not change(User, :count).by(1)
      end
    end
  end
  describe "UPDATE an exisitng user" do
    describe "with valid parameters" do
      it "should update the user" do
        visit edit_user_path(@user)
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
        click_button "Update User"
        page.should have_content("User was updated successfully.")
        current_path.should eq(user_path(@user))
      end
    end

    describe "with invalid parameters" do
      it "should not update the user if the email is blank" do
        visit edit_user_path(@user)
        fill_in "user_email", with: ""
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
        click_button "Update User"
        page.should have_content("can't be blank")
        current_path.should eq(user_path(@user))
      end

      it "should not update the user if the password is blank" do
        visit edit_user_path(@user)
        fill_in "user_password", with: ""
        fill_in "user_password_confirmation", with: "foobar"
        click_button "Update User"
        page.should have_content("doesn't match confirmation")
        current_path.should eq(user_path(@user))
      end

      it "should not update the user if the password confirmation is blank" do
        visit edit_user_path(@user)
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: ""
        click_button "Update User"
        # NOTE: the password field here doesn't persist because it's a password input
        # so we wont have the "can't be blank" message
        page.should have_content("doesn't match confirmation")
        current_path.should eq(user_path(@user))
      end
    end
  end

  describe "DESTROY'ing a user" do
    before(:each) do
      # Note: we can't destroy our own user (that we logged in as)
      # so use this test user
      @test_user = FactoryGirl.create(:user)
    end

    it "should destroy the specified user" do
      User.all.count.should eq(2)
      lambda do
        visit users_path
        click_link("user_destroy_#{@test_user.id}")
      end.should change(User, :count).by(-1)
      User.all.count.should eq(1)
    end
  end
end
