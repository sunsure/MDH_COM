class UsersController < ApplicationController
  load_and_authorize_resource except: [:create, :register]
  authorize_resource only: :create
  skip_before_filter :authorize, only: [:register, :create]

  respond_to :html, :js

  def index
  end

  def show
  end

  def new
  end

  def register
    # this is the public interface into registration
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(safe_params)
    if @user.save
      if current_user
        redirect_to @user, notice: t('users.controller.create.success')
      else
        cookies[:auth_token] = @user.auth_token # sign them in
        redirect_to root_url, notice: "Thanks for registering!"
      end
    else
      flash[:error] = t('users.controller.create.failure')
      render :new
    end
  end

  def update
    if @user.update_attributes(safe_params)
      redirect_to @user, notice: t('users.controller.update.success')
    else
      flash[:error] =  t('users.controller.update.failure')
      render :edit
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
    if current_user && current_user.is?(:admin)
      safe_attributes += [:role_ids]
    end
    params.require(:user).permit(*safe_attributes)
  end
end
