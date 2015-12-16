module ApplicationHelper
  def auth_logged_in?
    return true if session[:user_id]
  end
end
