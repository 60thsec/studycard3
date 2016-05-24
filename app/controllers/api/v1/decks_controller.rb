class Api::V1::DecksController < Api::V1::BaseController
  # before_action :authenticate

  def index
    user = authenticate

    render json: user
  end
end
