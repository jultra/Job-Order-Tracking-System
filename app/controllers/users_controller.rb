class UsersController < ApplicationController
  # layout :resolve_layout

  def index
    @users_active = User.all.where(:active => true)
    @users_inactive = User.all.where(:active => false)
  end

  def new
    @user = User.new
    # @office = Office.pluck(:name, :id)
  end

  def create
    @user = User.new(users_params)
    
    @user.active = true
    @user.approved = true
    @user.confirmed = true

    if @user.save
      set_role(@user)

      redirect_to @user 
    else 
      flash[:errors] = @user.errors.full_messages
      # redirect_to new_user_path
      render :new
    end

    # if @user.save_without_session_maintenance

    # else
    #   render :new
    # end

    # redirect_to @user
  end

  def signup
    @user = User.new
    # @office = Office.pluck(:name, :id)
  end

  def register
    @user = User.new(users_params)

    if @user.save
      set_role(@user)

      flash[:success] = "Account Request Submitted"
    else 
      flash[:errors] = @user.errors.full_messages
    end

    # redirect_to signup_user_path
    render :signup
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    # @office = Office.pluck(:name, :id)
  end

  def update
    @user = User.find(params[:id])

    if @user.update(users_params)
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      # redirect_to edit_user_path(@user)
      render :edit
    end
  end

  def destroy 
    # @user = User.find(params[:id])
    # @user.destroy

    # redirect_to users_path
  end 

  def activate
    @user = User.find params[:id]
    @user.update(:active => true, :approved => true, :confirmed => true)

    set_role(@user)

    redirect_to @user
  end

  def deactivate
    @user = User.find params[:id]
    @user.update(:active => false, :approved => false, :confirmed => false)

    redirect_to @user
  end

  private
  def set_role(user)
    if user.position == "Student"
      user.add_role :Student
    elsif user.position == "Administrator"
      user.add_role :Administrator
    elsif user.position == "Faculty"
      user.add_role :Faculty
    elsif user.position == "Staff"
      user.add_role :Staff
    elsif user.position == "Office Head"
      user.add_role :Office_Head
    end
    user.save!
  end

  def users_params
    params.require(:user).permit(:username, :office_id, :position, :fname, :mname, :lname, :email, :password, :password_confirmation)
  end
end
