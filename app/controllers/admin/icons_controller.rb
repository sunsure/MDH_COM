class Admin::IconsController < ApplicationController
  load_and_authorize_resource :icon
  respond_to :js

  def destroy
    @icon = Icon.find(params[:id])
    if @icon.destroy
      flash.now[:notice] = t('admin.icons.controller.destroy.success')
    else
      flash.now[:error] = t('admin.icons.controller.destroy.failure')
    end
  end

end
