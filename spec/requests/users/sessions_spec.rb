require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

  describe 'POST /create' do
    let!(:user) { create(:user, password: 'topsecret') }
    let(:user_params) do
      {
        email: user.email,
        password: 'topsecret'
      }
    end

    context 'when user is not signed in' do
      before do
        post user_session_path, params: { user: user_params }.to_json, headers: headers
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'creates a user' do
        expect(User.find_by(email: user_params[:email])).to be_present
      end
    end

    context 'when user is signed in and don\'t pass params' do
      before do
        post user_session_path, headers: Devise::JWT::TestHelpers.auth_headers(headers, user)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
