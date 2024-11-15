require 'swagger_helper'

RSpec.describe 'users/sessions', type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:Authorization) { nil }

  path '/api/v1/users/sign_in' do
    post('Create session') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email, example: 'user@example.com' },
              password: { type: :string, format: :password, example: 'topsecret' }
            },
            required: %w[email password]
          }
        }
      }

      response(200, 'successful response (user not signed in)') do
        let!(:user) { create(:user, password: 'topsecret') }
        let(:user_params) { { email: user.email, password: 'topsecret' } }
        let(:user) { { user: user_params } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(200, 'successful response (user signed in without params)') do
        let!(:user) { create(:user, password: 'topsecret') }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers(headers, user)['Authorization'] }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'unauthorized (invalid credentials)') do
        let(:user_params) { { email: 'invalid@example.com', password: 'wrongpassword' } }
        let(:user) { { user: user_params } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
