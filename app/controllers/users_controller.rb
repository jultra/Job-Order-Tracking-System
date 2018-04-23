class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(fname: params['fname'],mname: params['mname'],lname: params['lname'],position: params['position'], email: params['email'], password: params['password'] )
    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      puts "ggqwqwp"
      render :new
    end
  end

  private

  def users_params
    #params.require(:user).permit(:email, :password, :password_confirmation)
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
