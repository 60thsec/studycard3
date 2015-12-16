class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auth_log_in(@user)
      flash[:success] = "#{@user.username} created"
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.username} updated"
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    flash[:success] = "Deleted #{@user.username}"
    @user.destroy
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end

end
