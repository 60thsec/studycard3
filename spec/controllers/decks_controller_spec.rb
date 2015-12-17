require 'rails_helper'

RSpec.describe DecksController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @deck = FactoryGirl.create(:deck, user: @user)
    request.session[:user_id] = @user.id
  end

  describe "index" do
    it "assigns all of user's decks to @decks" do
      get :index
      expect(assigns :decks).to eq(@user.decks)
    end

    it "doesn't assign other users' decks to @decks" do
      other_user = FactoryGirl.create(:user)
      other_deck = FactoryGirl.create(:deck, user: other_user)

      get :index

      expect(assigns :decks).to include(@deck)
      expect(assigns :decks).to_not include(other_deck)
    end

    it "renders :index template" do
      get :index
      expect(response).to render_template :index
    end

    it "redirects if not logged in" do
      request.session[:user_id] = nil
      get :index

      expect(response).to redirect_to(login_url)
    end
  end

  describe "show" do
    it "assigns deck to @deck" do
      get :show, id: @deck
      expect(assigns :deck).to eq(@deck)
    end

    it "renders :show template" do
      get :show, id: @deck
      expect(response).to render_template :show
    end

    it "redirects if not signed in" do
      request.session[:user_id] = nil
      get :show, id: @deck

      expect(response).to redirect_to(login_path)
    end
  end

  describe "new" do
    it "assigns a new deck to @deck" do
      get :new
      expect(assigns :deck).to be_a_new(Deck)
    end

    it "renders :new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "redirects if not signed in" do
      session[:user_id] = nil
      get :new

      expect(response).to redirect_to(login_path)
    end
  end

  describe "create" do
    it "saves a new deck with valid input" do
      expect {
        post :create, deck: FactoryGirl.attributes_for(:deck)
      }.to change(Deck, :count).by(1)
    end

    it "doesn't save a new deck with invalid input" do
      expect {
        post :create, deck: FactoryGirl.attributes_for(:deck, title: nil)
      }.to_not change(Deck, :count)
    end

    it "redirects to decks#index" do
      post :create, deck: FactoryGirl.attributes_for(:deck)
      expect(response).to redirect_to(decks_url)
    end
  end

  describe "edit" do
    it "assigns deck to @deck" do
      get :edit, id: @deck
      expect(assigns :deck).to eq(@deck)
    end

    it "renders :edit template" do
      get :edit, id: @deck
      expect(response).to render_template(:edit)
    end

    it "redirects if not logged in" do
      request.session[:user_id] = nil
      get :edit, id: @deck

      expect(response).to redirect_to(login_url)
    end
  end

  describe "update" do
    it "updates the deck with valid input" do
      new_title = Faker::Lorem.word
      patch :update, id: @deck, deck: {title: new_title}
      @deck.reload
      expect(@deck.title).to eq(new_title)
    end

    it "doesn't update the deck with invalid input" do
      old_title = @deck.title
      patch :update, id: @deck, deck: {title: nil}
      @deck.reload
      expect(@deck.title).to eq(old_title)
    end

    it "redirects to deck#index" do
      new_title = Faker::Lorem.word
      patch :update, id: @deck, deck: {title: new_title}
      @deck.reload
      expect(@deck.title).to eq(new_title)

      expect(response).to redirect_to(decks_url)
    end
  end

  describe "destroy" do
    it "assigns the deck to @deck" do
      delete :destroy, id: @deck
      expect(assigns :deck).to eq(@deck)
    end

    it "deletes the deck" do
      expect {
        delete :destroy, id: @deck
      }.to change(Deck, :count).by(-1)
    end
  end
end
