require 'swagger_helper'

RSpec.describe 'api/v1/users/registrations', type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:Authorization) { nil }
  path '/api/v1/users' do
    post('Create user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: { '$ref' => '#/components/schemas/UserRegisterParams' }

      response(200, 'successful response') do
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, create(:user))['Authorization'] }
        let(:user) do
          {
            user: {
              email: 'test@example.com',
              password: 'password',
              password_confirmation: 'password'
            }
          }
        end

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

        run_test!
      end
    end

    put('Update user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :user, in: :body, schema: { '$ref' => '#/components/schemas/UserUpdateParams' }

      response(200, 'successful response') do
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, create(:user))['Authorization'] }
        let(:user) do
          {
            user: {
              email: 'user@example.com',
              name: 'User',
              feasibility_threshold: 0.5,
              adjustment_delta: 0.1
            }
          }
        end

        after do |example|
          if response
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
        end

        run_test!
      end

      response(401, 'unauthorized') do
        let(:user) do
          {
            user: {
              email: 'test@example.com'
            }
          }
        end

        after do |example|
          if response
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers(headers,
                                                create(:user, email: 'current_email@example.com'))['Authorization']
        end
        let(:user) do
          {
            user: {
              email: 'used_email@example.com'
            }
          }
        end
        let!(:user2) { create(:user, email: 'used_email@example.com') }

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
