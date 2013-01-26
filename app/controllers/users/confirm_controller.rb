class Users::ConfirmController < ApplicationController
  skip_before_filter :authorize
  before_filter :load_user, except: [:create]
  respond_to :html, :js

  def create
    @user = User.find_by_auth_token!(params[:auth_token])
    if @user.send_confirmation_email
      @result = true
      flash.now[:notice] = t('users.confirm.controller.create.success')
    else
      @result = false
      flash.now[:error] = t('users.confirm.controller.create.failure')
    end
  end

  def edit
    authorize! :confirm, User
  end

  def update
    authorize! :confirm, User
    if @user.confirm_account
      redirect_to login_url, notice: t('users.confirm.controller.update.success')
    else
      flash.now[:error] = t('users.confirm.controller.update.failure')
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by_confirm_token!(params[:id])
  end

end
