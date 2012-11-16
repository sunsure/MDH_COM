class Admin::UsersController < ApplicationController
  load_and_authorize_resource except: [:create]
  authorize_resource only: :create

  respond_to :html, :js
  layout "admin"

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @user = User.new(safe_params)
    if @user.save
      redirect_to @user, notice: t('admin.users.controller.create.success')
    else
      flash[:error] = t('admin.users.controller.create.failure')
      render :new
    end
  end

  def update
    if @user.update_attributes(safe_params)
      redirect_to @user, notice: t('admin.users.controller.update.success')
    else
      flash[:error] =  t('admin.users.controller.update.failure')
      render :edit
    end
  end

  def destroy
    unless @user == current_user
      @user.destroy
      flash[:notice] = t('admin.users.controller.destroy.success')
    else
      flash[:error] = t('admin.users.controller.destroy.prevent_self_destroy')
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
