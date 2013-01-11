class AdminController < ApplicationController
  before_filter :ensure_admin
  layout 'admin'

  private

  # Make sure it's an admin looking at this stuff
  def ensure_admin
    redirect_to unauthorized_url unless current_user.is?(:admin)
  end

end