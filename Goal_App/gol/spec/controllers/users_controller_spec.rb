require 'rails_helper'

RSpec.describe UsersController, type: :controller do


  describe 'GET #new' do
    it 'renders the users sign up page' do

      get :new

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    
    context 'with valid params' do
      it ' saves to db, and redirects to user show page' do
        post :create, params: { user: {username: 'username', password: 'password'}}
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context 'with invalid params' do
      it 'redirects to new user sign up page' do
        post :create, params: { user: {username: 'username'}}
        expect(response).to render_template('new')
      end
    end
  end
end
