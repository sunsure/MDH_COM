class UsersController < ApplicationController

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(safe_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was created successfully.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(safe_params)
        format.html { redirect_to @user, notice: 'User was updated successfully.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless @user == current_user
      @user.destroy
    else
      flash[:error] = t('users.controller.destroy.prevent_self_destroy')
    end

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
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
    if current_user.is? :admin
      safe_attributes += [:role_ids]
    end
    params.require(:user).permit(*safe_attributes)
  end
end
