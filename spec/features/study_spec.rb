require 'rails_helper'

feature 'Study Console' do
  before do
    @user = FactoryGirl.create(:user)
    @deck = FactoryGirl.create(:deck, user: @user)
    5.times { FactoryGirl.create(:card, deck: @deck) }

    visit login_path
    fill_in 'session[username]', with: @user.username
    fill_in 'session[password]', with: 'password'
    within('main') do
      click_button('Sign in')
    end

    visit deck_path(@deck)
  end

  it 'loads next due card' do
    expect(page).to have_content(@deck.title)
  end

end
