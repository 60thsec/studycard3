class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])

    if @user && @user.authenticate(params['session']['password'])
      auth_log_in(@user)
      redirect_to root_path
    else
      flash[:error] = "Sorry, username or password was invalid."
      render 'sessions/new'
    end
  end

  def destroy
    session.destroy
    redirect_to root_url
  end
end
