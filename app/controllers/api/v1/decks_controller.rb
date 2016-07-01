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
    # user = authenticate
    deck = Deck.find(params[:id])

    render json: deck.get_next_card
  end

  def study
    p params
    unless params[:rating] == 'init'
      Card.find(params[:card]).supermemo(params[:rating])
    end

    @deck = Deck.find(2)
    render json: @deck.get_next_card
  end
end
