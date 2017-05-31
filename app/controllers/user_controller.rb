class UserController < ApplicationController
  
  @order = -1
  
  def index
    @users = User.all
  end

  def login
  end

  def register
    user = User.find_by_email(params[:user_id])
    if user.present?
      @order = 100
      redirect_to "/login"
    else
    user = User.new(email: params[:user_id], password: params[:password], password_confirmation: params[:password_confirmation])
    user.save
    @order = 200
    redirect_to "/login"
    end
  end

  def signup
  end
  
  def user_login
    user = User.find_by_email(params[:user_id])
    if user.present? && user.authenticate(params[:password])
      # login success
      session[:user_id] = user.id
      redirect_to "/"
    else
      redirect_to "/login"
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to "/"
  end
end
