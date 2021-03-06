require 'pp'

class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to :root
    else
      redirect_to new_user_path
    end
  end

  private

  def user_params
    # enforce downcase of email in db
    params.require(:user)[:email].downcase!
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
