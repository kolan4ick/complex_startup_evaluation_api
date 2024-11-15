require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

  describe 'POST /create' do
    context 'when user is not signed in' do
      let(:user_params) { attributes_for(:user) }

      before do
        post user_registration_path, params: { user: user_params }.to_json, headers: headers
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'creates a user' do
        expect(User.find_by(email: user_params[:email])).to be_present
      end
    end

    context 'when user is signed in' do
      let(:user_params) { attributes_for(:user) }
      let(:user) { create(:user, user_params) }

      before do
        post user_registration_path, params: { user: user_params }.to_json,
                                     headers: Devise::JWT::TestHelpers.auth_headers(headers, user)
      end

      it 'returns a 422 error' do
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'PUT /update' do
    context 'when user is signed in' do
      let(:user) { create(:user) }
      let(:user_params) { attributes_for(:user, name: 'Mykola', adjustment_delta: 0.4, feasibility_threshold: 0.66) }

      before do
        put user_registration_path, params: { user: user_params }.to_json,
                                    headers: Devise::JWT::TestHelpers.auth_headers(headers, user)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'updates the user' do
        user.reload
        expect(user.name).to eq(user_params[:name])
        expect(user.email).to eq(user_params[:email])
        expect(user.feasibility_threshold).to eq(user_params[:feasibility_threshold])
        expect(user.adjustment_delta).to eq(user_params[:adjustment_delta])
      end
    end

    context 'when user is not signed in' do
      let(:user_params) { attributes_for(:user) }

      before do
        put user_registration_path, params: { user: user_params }, headers: headers
      end

      it 'returns a 401 error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
