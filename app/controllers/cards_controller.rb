class CardsController < ApplicationController
  before_action :set_deck
  before_action :set_card, except: [:index, :new, :create]
  before_action :check_auth

  def index
    @cards = @deck.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = @deck.cards.new(card_params)
    if @card.save
      flash[:success] = "Card saved"
      redirect_to new_deck_card_url(@deck)
    else
      flash[:error] = "Card not saved"
      render :new
    end
  end

  def update
    if @card.update_attributes(card_params)
      redirect_to deck_cards_url
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to deck_cards_url
  end

  private
    def card_params
      params.require(:card).permit(:front, :back)
    end

    def set_card
      @card = Card.find(params[:id])
    end

    def set_deck
      @deck = Deck.find(params[:deck_id])
    end
end
