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
    prev_card = Card.find(params[:card])
    puts '*' * 50
    p prev_card

    unless params[:rating] == 'init'
      prev_card.supermemo(params[:rating])
    end

    @deck = Deck.find(Card.find(params[:card]).deck)
    card = @deck.get_next_card.attributes
    card['prev_card'] = "\"#{prev_card.front}\" will be due again #{prev_card.due.strftime('%A %B %-d, %Y')}"
    puts '&' * 50
    p card
    # render json: @deck.get_next_card
    render json: card
  end
end
