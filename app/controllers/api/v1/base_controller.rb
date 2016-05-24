class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate
    user = User.find(params[:user])

    if user.auth_token == params[:auth]
      return user
    else
      self.status = :unauthorized
      self.response_body = { error: 'Access denied' }.to_json
    end
  end
end
