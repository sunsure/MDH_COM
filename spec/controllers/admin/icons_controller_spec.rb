require 'spec_helper'

describe Admin::IconsController do

  describe "DELETE destroy" do
    before(:each) do
      @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
      login_as(@user)
      expect {
        @icon = FactoryGirl.create(:icon)
      }.to change(Icon, :count).by(1)
    end
    it "destroys the requested image", js: true do
      expect {
        delete :destroy, id: @icon.to_param, article_id: @icon.assetable.to_param, format: :js
      }.to change(Icon, :count).by(-1)
    end
  end

end
