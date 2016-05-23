class Api::V1::SessionsController < Api::V1::BaseController
  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params['password'])
      render json: {auth: @user.auth_token, user: @user.id}
    else
      self.status = :unauthorized
      self.response_body = { error: 'Access denied' }.to_json
    end
  end
end
