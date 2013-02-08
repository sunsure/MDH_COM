require 'spec_helper'

describe Admin::ImagesController do

  describe "DELETE destroy" do
    before(:each) do
      @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
      login_as(@user)
      expect {
        @image = FactoryGirl.create(:image)
      }.to change(Image, :count).by(1)
    end
    it "destroys the requested image", js: true do
      expect {
        delete :destroy, id: @image.to_param, article_id: @image.assetable.to_param, format: :js
      }.to change(Image, :count).by(-1)
    end
  end

end
