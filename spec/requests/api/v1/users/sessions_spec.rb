require 'swagger_helper'

RSpec.describe 'users/sessions', type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:Authorization) { nil }

  path '/api/v1/users/sign_in' do
    post('Create session') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: { '$ref' => '#/components/schemas/UserLoginParams' }
      security [bearerAuth: []]

      response(200, 'successful response (user not signed in)') do
        before do
          create(:user, email: 'test@example.com', password: 'topsecret')
        end

        let(:user) do
          {
            user: {
              email: 'test@example.com',
              password: 'topsecret'
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

      response(200, 'successful response (user signed in without params)') do
        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers(headers, create(:user, password: 'topsecret'))['Authorization']
        end

        let(:user) do
          {
            user: {}
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

      response(401, 'unauthorized (invalid credentials)') do
        let(:user) do
          {
            user: {
              email: 'invalid@example.com',
              password: 'wrongpassword'
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
    end
  end
end
