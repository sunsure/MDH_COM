class UsersController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  load_and_authorize_resource except: [:new, :create]
  authorize_resource only: :create
  respond_to :html

  def new
    if current_user
      # don't let them register if they're already logged in
      redirect_to dashboard_my_url, notice: t('users.controller.new.already_logged_in')
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(safe_params)
    if @user.save
      flash[:notice] = t('users.controller.create.success')
      redirect_to login_url
    else
      flash[:error] = t('users.controller.create.failure')
      render :new
    end
  end

  def destroy
    unless @user == current_user
      @user.destroy
      flash[:notice] = t('users.controller.destroy.success')
    else
      flash[:error] = t('users.controller.destroy.prevent_self_destroy')
    end
    redirect_to users_url
  end

  private

  def safe_params
    safe_attributes = [
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
    ]
    params.require(:user).permit(*safe_attributes)
  end

end
