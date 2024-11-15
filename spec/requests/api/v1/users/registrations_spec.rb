require 'swagger_helper'

RSpec.describe 'api/v1/users/registrations', type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:Authorization) { nil }

  path '/api/v1/users' do
    post('Create user') do
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
              password: { type: :string, format: :password, example: 'password123' },
              password_confirmation: { type: :string, format: :password, example: 'password123' }
            },
            required: %w[email password password_confirmation]
          }
        }
      }

      response(200, 'successful response') do
        let(:user_params) { attributes_for(:user) }
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

      response(422, 'unprocessable entity') do
        let(:user_params) { { email: '', password: '', password_confirmation: '' } }
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

    put('Update user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Mykola' },
              email: { type: :string, format: :email, example: 'updated_user@example.com' },
              feasibility_threshold: { type: :number, format: :float, example: 0.66 },
              adjustment_delta: { type: :number, format: :float, example: 0.4 }
            }
          }
        }
      }

      response(200, 'successful response') do
        let(:user) { create(:user) }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers(headers, user)['Authorization'] }
        let(:user_params) { attributes_for(:user, name: 'Mykola', feasibility_threshold: 0.66, adjustment_delta: 0.4) }
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

      response(401, 'unauthorized') do
        let(:user_params) { attributes_for(:user) }
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

      response(422, 'unprocessable entity') do
        let(:user) { create(:user) }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers(headers, user)['Authorization'] }
        let(:user_params) { { email: '' } }
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
