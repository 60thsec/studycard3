class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def auth_log_in(user)
      session[:user_id] = user.id
      flash[:notice] = "Hello, #{user.username}"
    end

    def get_current_user
      User.find(session[:user_id])
    end

    def check_auth
      redirect_to login_url unless session[:user_id]
    end
end
