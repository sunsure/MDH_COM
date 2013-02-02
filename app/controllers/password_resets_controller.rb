class PasswordResetsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.find_by_email(params[:user].try(:[], :email))
    if user
      user.update_attribute(:password_reset_sent_at, Time.zone.now)
      user.send_password_reset_email
    end
    redirect_to login_url, notice: t("password_resets.controller.create.success")
  end

  def edit
    # find the user by their password reset token, or throw a 404
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < (Time.zone.now - 2.hours)
      flash[:error] = t("password_resets.controller.update.expired")
      redirect_to login_url
    elsif @user.update_attributes(safe_params)
      @user.destroy_password_reset
      redirect_to login_path, notice: t("password_resets.controller.update.success")
    else
      # get it right, dingus
      render :edit
    end
  end

  private

  def safe_params
    safe_attributes = [
      :password,
      :password_confirmation
    ]
    params.require(:user).permit(*safe_attributes)
  end
end
