class Api::V1::DecksController < Api::V1::BaseController
  before_action :authenticate

  def index
    user = User.find(params[:user])
    decks = []

    user.decks.each do |deck|
      decks << {id: deck.id, title: deck.title}
    end

    render json: decks
  end

  def show
    user = authenticate
    deck = Deck.find(params[:id])

    render json: deck
  end
end
