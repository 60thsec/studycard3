class Api::V1::DecksController < Api::V1::BaseController
  # before_action :authenticate

  def index
    user = authenticate
    decks = []

    user.decks.each do |deck|
      decks << {id: deck.id, title: deck.title}
    end

    render json: decks
  end
end
