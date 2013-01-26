class SessionsController < ApplicationController
  skip_before_filter :authorize
  before_filter :require_confirmation, only: [:create]

  def new
  end

  def create
    user = User.find_by_email(params[:email].to_s.downcase)
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      if user.is?(:admin)
        if session[:redirect_to].present?
          # go back where we tried to go to
          redirect_to session[:redirect_to]
        else
          # if we didn't try to go anywhere, then go to admin
          redirect_to admin_root_url, notice: t("application.notices.authorization.success")
        end
      else
        if session[:redirect_to].present?
          # normal user trying to go somewhere but required login
          redirect_to session[:redirect_to]
        else
          # otherwise just go home
          redirect_to root_url, notice: t("application.notices.authorization.success")
        end
      end
    else
      # no user found or bad credentials
      flash[:error] = t("application.errors.authorization.failure")
      redirect_to login_url
    end
  end

  def destroy
    cookies.delete(:auth_token)
    reset_session
    redirect_to root_url, notice: t("application.notices.authorization.reset_session")
  end

  def unauthorized
  end

  def confirm_account
    @user = User.find_by_auth_token!(params[:auth_token])
  end

  private

  def require_confirmation
    # Make sure they've been confirmed
    user = User.find_by_email(params[:email].to_s.downcase)
    if user && user.authenticate(params[:password])
      unless user.confirmed?
        flash.now[:error] = t("sessions.controller.require_confirmation.failure")
        redirect_to confirm_account_url(user.auth_token) and return
      end
    end
  end

end
