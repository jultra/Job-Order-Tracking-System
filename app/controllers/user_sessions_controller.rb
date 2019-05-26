class UserSessionsController < ApplicationController
  layout :resolve_layout

  def new
    # User.find(1).add_role :SAO_admin
    if current_user_session != nil
      current_user_session.destroy
    else
      session.destroy
    end
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params.to_h)
    if @user_session.save
      redirect_to job_order_tracking_system_path
    else
      flash[:errors] = @user_session.errors.full_messages
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    #flash[:success] = "Goodbye!"
    redirect_to root_path
  end

  private

  def user_session_params
    # params.require(:user_session).permit(:email, :password)
    params.require(:user_session).permit(:username, :password)
  end

  def resolve_layout
    case action_name
      when "new"
        "login"
      when "destroy"
        "login"
      when "create"
        "login"        
      else 
        "application"
    end
  end
end
