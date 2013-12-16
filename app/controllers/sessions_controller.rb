class SessionsController < ApplicationController

  def create
    user = User.where(:name => params[:signin][:name]).first
    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      flash[:notice] = "Signed in successfully."
      redirect_to root_url
    else
      flash[:error] = "Sorry."
      render :new
    end 
  end

  def oath_create
    oname = (env["omniauth.auth"])["uid"]+"_twitter"
    omail = env["omniauth.auth"]["info"]["nickname"]
    user = User.where(:name => oname).first
    if not user
      opassword = SecureRandom.urlsafe_base64(n=6)
      User.create!(:email => omail, :name => oname, :password => opassword, :password_confirmation => opassword )
      user = User.where(:name => oname).first
    end
    session[:user_id] = user.id
    flash[:notice] = "Signed in successfully."
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out successfully."

    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
