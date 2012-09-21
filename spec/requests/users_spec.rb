require 'spec_helper'

describe "Users" do
  before(:each) do
    @first = FactoryGirl.create(:user)
    @second = FactoryGirl.create(:user)
  end

  describe "GET /users" do
    it "should display a list of users" do
      visit users_path

      # first user
      page.should have_content(@first.first_name)
      page.should have_content(@first.last_name)
      page.should have_content(@first.email)

      # second user
      page.should have_content(@second.first_name)
      page.should have_content(@second.last_name)
      page.should have_content(@second.email)

      # other things
      page.should have_selector('h1', content: "Listing Users")
    end
  end
end
