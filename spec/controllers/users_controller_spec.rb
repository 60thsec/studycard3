require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#show" do
    it "assigns user to @user" do
      user = FactoryGirl.create(:user)
      get :show, id: user

      expect(assigns(:user)).to eq(user)
    end

    it "renders :show template" do
      user = FactoryGirl.create(:user)
      get :show, id: user

      expect(response).to render_template(:show)
    end
  end

  describe "#new" do
    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid input" do
      it "saves the new user to the database" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "assigns the new user to @user" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user).id).to eq(User.last.id)
      end

      it "logs the new user in" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects to users#show" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to(user_url(assigns :user))
      end
    end

    context "with invalid input" do
      it "doesn't save the new user to the database" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end

      it "renders :new template" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#edit" do
    before :all do
      @user = FactoryGirl.create(:user)
    end

    it "assigns the correct user to @user" do
      get :edit, id: @user
      expect(assigns(:user)).to eq(@user)
    end

    it "renders :edit template" do
      get :edit, id: @user
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    before :all do
      @testuser = FactoryGirl.create(:user)
    end

    it "assigns the correct user to @user" do
      patch :update, id: @testuser, user: {username: @testuser.username,
                                           password: 'password'}
      expect(assigns(:user)).to eq(@testuser)
    end

    it "updates the user with valid input" do
      post :update, id: @testuser,
                    user: FactoryGirl.attributes_for(:user, username: 'updated')
      @testuser.reload
      expect(@testuser.username).to eq('updated')
    end

    it "doesn't update the user with invalid input" do
      @testuser.reload
      old_username = @testuser.username
      post :update, id: @testuser,
                    user: FactoryGirl.attributes_for(:user, username: nil)
      @testuser.reload
      expect(@testuser.username).to eq(old_username)
    end
  end

  describe "#destroy" do
    before :each do
      @testuser = FactoryGirl.create(:user)
    end

    it "assigns the correct user to @user" do
      delete :destroy, id: @testuser.id
      expect(assigns(:user)).to eq(@testuser)
    end

    it "deletes the user" do
      expect{
        delete :destroy, id: @testuser.id
      }.to change(User, :count).by(-1)
    end
  end
end
