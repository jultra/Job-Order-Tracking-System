class SessionsController < ApplicationController

  def login
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to :controller => "users", :action => "index"
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid Email/Password'
      render 'login'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end


end
