class DecksController < ApplicationController
  before_action :check_auth
  before_action :assign_deck, except: [:index, :new, :create]

  def index
    user = get_current_user
    @decks = user.decks
  end

  def show
    redirect_to new_deck_card_url(@deck) if @deck.cards.count == 0
  end

  def new
    @deck = Deck.new
  end

  def create
    deck = get_current_user.decks.new(deck_params)

    if deck.save
      redirect_to new_deck_card_path(deck)
    else
      render :new
    end
  end

  def update
    if @deck.update_attributes(deck_params)
      redirect_to(decks_url)
    else
      render :edit
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_url
  end

  def study
    Card.find(params[:card]).supermemo(params[:rating])
    render json: { 'card' => @deck.get_next_card, 'message' => '' }
  end

  private
    def deck_params
      params.require(:deck).permit(:title)
    end

    def assign_deck
      @deck = Deck.find(params[:id])
    end
end
