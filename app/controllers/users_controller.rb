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

  def index
    @user = User.find(session['user_credentials_id'])
    @user2 = User.all.where(:active => false, :approved => false, :confirmed => false)
  end

  def approve
    user = User.find params[:id]
    user.update(:approved => true, :confirmed => true, :active => true)
    user.save
    if user.position == "Student"
      user.add_role :Student
    elsif user.position == "Adviser"
      user.add_role :Adviser
    elsif user.position == "Faculty"
      user.add_role :Faculty
    elsif user.position == "Staff"
      user.add_role :Staff
    elsif user.position == "Chairperson/Head"
      user.add_role :Head
    end
    redirect_to users_path
  end

  def reject
    user = User.find params[:id]
    user.destroy
    redirect_to users_path
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
