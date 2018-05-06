class UserSessionsController < ApplicationController
  layout :resolve_layout

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params.to_h)
    if @user_session.save
      flash[:status] = "Welcome back!"
      redirect_to '/request_form'
    else
      flash[:status] = "Email/Password Incorrect!"
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    #flash[:success] = "Goodbye!"
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end

  def resolve_layout
    case action_name
      when "new"
        "login"
      when "destroy"
        "login"
      else 
        "application"
    end
  end
end
