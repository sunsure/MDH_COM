class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.find_by_email(params[:email].to_s.downcase)
    if user && user.authenticate(params[:password])
      cookies[:auth_token] = user.auth_token
      redirect_to root_path, notice: t("application.notices.authorization.success")
    else
      # no user found or bad credentials
      flash[:error] = t("application.errors.authorization.failure")
      redirect_to login_path
    end
  end

  def destroy
    cookies.delete(:auth_token)
    reset_session
    redirect_to root_url, notice: t("application.notices.authorization.reset_session")
  end

  def unauthorized
  end

end
