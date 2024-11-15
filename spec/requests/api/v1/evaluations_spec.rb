require 'swagger_helper'

RSpec.describe 'api/v1/evaluations', type: :request do
  path '/api/v1/evaluations' do
    get('List evaluations') do
      tags 'Evaluations'
      produces 'application/json'
      security [bearerAuth: []]

      response(200, 'successful') do
        schema type: :array, items: { '$ref' => '#/components/schemas/Evaluation' }

        let(:user) { create(:user) }
        let!(:evaluation) { create(:evaluation, user:) }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }

        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end
    end

    post('Create evaluation') do
      tags 'Evaluations'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :evaluation, in: :body, schema: { '$ref' => '#/components/schemas/EvaluationParams' }

      response(200, 'successful') do
        let(:user) { create(:user) }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:evaluation) do
          {
            evaluation: {
              team_competencies: 7,
              team_competencies_and_experience: 7,
              team_leaders_competencies: 7,
              team_professional_activity: 7,
              team_stability: 7,
              feasibility_linguistic: 'high'
            }
          }
        end

        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end
    end
  end

  path '/api/v1/evaluations/{id}' do
    get('Show evaluation') do
      tags 'Evaluations'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, type: :string, description: 'Evaluation ID'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/Evaluation'

        let(:user) { create(:user) }
        let!(:evaluation) { create(:evaluation, user:) }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:id) { evaluation.id }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:id) { create(:evaluation).id }
        run_test!
      end

      response(404, 'not found') do
        let(:user) { create(:user) }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:id) { 'non-existent-id' }

        run_test!
      end
    end
  end
end
