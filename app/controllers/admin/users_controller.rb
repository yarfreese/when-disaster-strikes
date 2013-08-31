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
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render :action => "new"
    end
  end
  def show
    puts @user
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
    puts @user
  end
end
# class Admin::UsersController < ApplicationController
# switched to BaseController because using admin namespace
# "Because Admin::UsersController now inherits from Admin::BaseController , the before_filter from
# Admin::BaseController now runs for every action inside Admin::UsersController" 
