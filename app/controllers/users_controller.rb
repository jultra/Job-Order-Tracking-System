class UsersController < ApplicationController
  layout :resolve_layout

  def new
    if current_user_session != nil
      current_user_session.destroy
    else
      session.destroy
    end
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save_without_session_maintenance
      flash.keep
      flash[:success] = "Account Request Submitted"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def users_params
    params.require(:user).permit(:username, :Division_Department, :position, :fname, :mname, :lname, :email, :password, :password_confirmation)
  end

  def resolve_layout
    case action_name
      when "new"
        "login"
      when "create"
        "login"  
      else 
        "application"
    end
  end
end
