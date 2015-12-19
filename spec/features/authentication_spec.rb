require 'rails_helper'

feature "Logging in" do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "works with a valid username and password" do
    visit '/login'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    within('main') do
      click_button('Sign in')
    end

    expect(page).to have_content("Hi, #{@user.username}")
  end

  it "doesn't work with an invalid username" do
    visit '/login'
    fill_in 'Username', with: 'not_a_user'
    fill_in 'Password', with: @user.password
    within('main') do
      click_button('Sign in')
    end

    expect(page).to have_content("Sorry, username or password was invalid")
  end

  it "doesn't work with an invalid password" do
    visit '/login'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: 'not_the_right_password'
    within('main') do
      click_button('Sign in')
    end

    expect(page).to have_content("Sorry, username or password was invalid")
  end

end

feature "Logging out" do
  before do
    @user = FactoryGirl.create(:user)

    visit '/login'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    within('main') do
      click_button('Sign in')
    end
  end

  it "logs the user out" do
    click_on "Sign Out"
    expect(page).to have_content("Goodbye, #{@user.username}")
  end
end
