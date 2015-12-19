class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])

    if @user && @user.authenticate(params['session']['password'])
      auth_log_in(@user)
      flash[:success] = "Hi, #{@user.username}"
      redirect_to decks_url
    else
      flash[:error] = "Sorry, username or password was invalid."
      render 'sessions/new'
    end
  end

  def destroy
    @user = get_current_user
    flash[:notice] = "Goodbye, #{@user.username}"
    session.destroy

    redirect_to login_url
  end
end
