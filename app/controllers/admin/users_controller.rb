class Admin::UsersController < Admin::BaseController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:email)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User has been created."
    else
      flash.now[:alert] = "User has not been created."
      render :action => "new"
    end
    redirect_to admin_users_path
  end
  def edit
  end
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
    #if @user.update_attributes(params[:user], :as => :admin)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render action: "edit"
    end
  end
  def show
    #puts @user
  end
  def destroy
    if @user == current_user
      flash[:alert] = "You cannot delete yourself!"
    else 
      @user.destroy
      flash[:notice] = "User has been deleted."
    end
    redirect_to admin_users_path
  end

private
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :admin)
  end

private
  def find_user
    @user = User.find(params[:id])
    # puts @user
  end
end
# class Admin::UsersController < ApplicationController
# switched to BaseController because using admin namespace
# "Because Admin::UsersController now inherits from Admin::BaseController , the before_filter from
# Admin::BaseController now runs for every action inside Admin::UsersController" 
