class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate

  def show
    user = User.find(params[:id]);

    render json: user
  end

  protected
  def authenticate
    return true if User.find(params[:user]).auth_token == params[:auth]
    self.status = :unauthorized
    self.response_body = { error: 'Access denied' }.to_json
  end
end
