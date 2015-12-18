require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @deck = FactoryGirl.create(:deck, user: @user)
    @card = FactoryGirl.create(:card, deck: @deck)
    request.session[:user_id] = @user.id
  end

  describe "index" do
    it "assigns all of deck's cards to @cards" do
      get :index, deck_id: @deck
      expect(assigns :cards).to eq(@deck.cards)
    end

    it "doesn't assign other decks' cards to @cards" do
      other_deck = FactoryGirl.create(:deck)
      other_card = FactoryGirl.create(:card, deck: other_deck)

      get :index, deck_id: @deck

      expect(assigns :cards).to include(@card)
      expect(assigns :cards).to_not include(other_card)
    end

    it "renders :index template" do
      get :index, deck_id: @deck
      expect(response).to render_template :index
    end

    it "redirects if not logged in" do
      request.session[:user_id] = nil
      get :index, deck_id: @deck

      expect(response).to redirect_to(login_url)
    end
  end

  describe "show" do
    it "assigns card to @card" do
      get :show, deck_id: @deck, id: @card
      expect(assigns :card).to eq(@card)
    end

    it "renders :show template" do
      get :show, deck_id: @deck, id: @card
      expect(response).to render_template :show
    end

    it "redirects if not signed in" do
      request.session[:user_id] = nil
      get :show, deck_id: @deck, id: @card

      expect(response).to redirect_to(login_path)
    end
  end

  describe "new" do
    it "assigns a new card to @card" do
      get :new, deck_id: @deck
      expect(assigns :card).to be_a_new(Card)
    end

    it "renders :new template" do
      get :new, deck_id: @deck
      expect(response).to render_template(:new)
    end

    it "redirects if not signed in" do
      session[:user_id] = nil
      get :new, deck_id: @deck

      expect(response).to redirect_to(login_path)
    end
  end

  describe "create" do
    it "saves a new deck with valid input" do
      expect {
        post :create, deck_id: @deck, card: FactoryGirl.attributes_for(:card, deck: @deck)
      }.to change(Card, :count).by(1)
    end

    it "doesn't save a new deck with invalid input" do
      expect {
        post :create, deck_id: @deck, card: FactoryGirl.attributes_for(:card, front: nil, deck: @deck)
      }.to_not change(Deck, :count)
    end

    it "redirects to cards#index" do
      post :create, deck_id: @deck, card: FactoryGirl.attributes_for(:card)
      expect(response).to redirect_to(deck_cards_url)
    end
  end

  describe "edit" do
    it "assigns card to @card" do
      get :edit, deck_id: @deck, id: @card
      expect(assigns :card).to eq(@card)
    end

    it "renders :edit template" do
      get :edit, deck_id: @deck, id: @card
      expect(response).to render_template(:edit)
    end

    it "redirects if not logged in" do
      request.session[:user_id] = nil
      get :edit, deck_id: @deck, id: @card

      expect(response).to redirect_to(login_url)
    end
  end

  describe "update" do
    it "updates the card with valid input" do
      new_front = Faker::Lorem.word
      patch :update, deck_id: @deck, id: @card, card: {front: new_front}
      @card.reload
      expect(@card.front).to eq(new_front)
    end

    it "doesn't update the deck with invalid input" do
      old_front = @card.front
      patch :update, deck_id: @deck, id: @card, card: {front: nil}
      @card.reload
      expect(@card.front).to eq(old_front)
    end

    it "redirects to card#index" do
      new_front = Faker::Lorem.word
      patch :update, deck_id: @deck, id: @card, card: {front: new_front}
      @card.reload
      expect(@card.front).to eq(new_front)

      expect(response).to redirect_to(deck_cards_url)
    end
  end

  describe "destroy" do
    it "assigns the card to @card" do
      delete :destroy, deck_id: @deck, id: @card
      expect(assigns :card).to eq(@card)
    end

    it "deletes the card" do
      expect {
        delete :destroy, deck_id: @deck, id: @card
      }.to change(Card, :count).by(-1)
    end
  end
end
