module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # logs out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
    # Return current user if already called (if nil will then) -> find and return the current user 
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) 
  end

  def logged_in?
    !current_user.nil? # not nil
  end
end
