class NotificationsController < ActionController::Base
  # before_action :require_user
  
  def index 
  	@current_user = User.find session['user_credentials_id']
    print "Current user: " + @current_user.username 
    @notifications = Notification.where(recipient: @current_user).unread
  end

  def mark_as_read
  	@current_user = User.find session['user_credentials_id']
    @notifications = Notification.where(recipient: @current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end
end
