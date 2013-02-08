class Admin::ImagesController < ApplicationController
  load_and_authorize_resource :article, find_by: :permalink
  load_and_authorize_resource :image, through: :article
  respond_to :js

  def destroy
    if @image.destroy
      flash.now[:notice] = t('admin.images.controller.destroy.success')
    else
      flash.now[:error] = t('admin.images.controller.destroy.failure')
    end
  end

end
