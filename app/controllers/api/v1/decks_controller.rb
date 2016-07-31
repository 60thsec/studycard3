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
    deck_id = params[:id] || params[:deck]
    deck = Deck.find(deck_id)

    p deck.get_next_card

    render json: deck.get_next_card
  end

  def study
    puts '*' * 50
    p params

    unless params[:rating] == 'init'
      Card.find(params[:card]).supermemo(params[:rating])
    end

    @deck = Deck.find(Card.find(params[:card]).deck)
    render json: @deck.get_next_card
  end
end
