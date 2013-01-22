class ApplicationController < ActionController::Base
  before_filter :authorize

  protect_from_forgery

  # What CanCan should do when a user is unauthorized
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t("application.errors.authorization.unauthorized")
    redirect_to unauthorized_url
  end

  private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if (cookies[:auth_token])
  end
  helper_method :current_user

  def authorize
    if current_user.nil?
      session[:redirect_to] = request.url
      flash[:notice] = t("application.errors.authorization.please_authenticate")
      redirect_to login_url
    end
  end

end
