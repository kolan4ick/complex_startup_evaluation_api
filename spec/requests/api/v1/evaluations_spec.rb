require 'swagger_helper'

RSpec.describe 'api/v1/evaluations', type: :request do
  let(:user) { create(:user) }
  let(:Authorization) { nil }

  path '/api/v1/evaluations' do
    get('List evaluations') do
      tags 'Evaluations'
      produces 'application/json'
      security [bearerAuth: []]

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 evaluations: {
                   type: :array,
                   items: { '$ref' => '#/components/schemas/Evaluation' }
                 },
                 meta: {
                   type: :object,
                   properties: {
                     current_page: { type: :integer, example: 1 },
                     total_pages: { type: :integer, example: 1 },
                     total_count: { type: :integer, example: 1 },
                     per_page: { type: :integer, example: 20 }
                   },
                   required: %w[current_page total_pages total_count per_page]
                 }
               },
               required: %w[evaluations meta]

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
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:evaluation) do
          {
            evaluation: {
              team_competencies: 7,
              team_competencies_and_experience: 7,
              team_leaders_competencies: 7,
              team_professional_activity: 7,
              team_stability: 7,
              effectiveness_sum_scores_attributes: attributes_for_list(:effectiveness_sum_score, 5),
              effectiveness_min_scores_attributes: attributes_for_list(:effectiveness_min_score, 5),
              effectiveness_max_scores_attributes: attributes_for_list(:effectiveness_max_score, 5),
              effectiveness_desired_scores_attributes: attributes_for_list(:effectiveness_desired_score, 5),
              effectiveness_weight_scores_attributes: attributes_for_list(:effectiveness_weight_score, 5),
              effectiveness_desired_term_scores_attributes: attributes_for_list(:effectiveness_desired_term_score, 5),
              risk_financial_scores_attributes: attributes_for_list(:risk_financial_score, 5),
              risk_investment_scores_attributes: attributes_for_list(:risk_investment_score, 5),
              risk_operational_scores_attributes: attributes_for_list(:risk_operational_score, 9),
              risk_innovation_activity_scores_attributes: attributes_for_list(:risk_innovation_activity_score, 5),
              team_stability_scores_attributes: attributes_for_list(:team_stability_score, 2),
              team_professional_competency_scores_attributes: attributes_for_list(:team_professional_competency_score,
                                                                                  5),
              team_professional_activity_scores_attributes: attributes_for_list(:team_professional_activity_score, 4),
              feasibility_linguistic: :high
            }
          }
        end

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }
        let(:evaluation) { nil }

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
        schema '$ref' => '#/components/schemas/EvaluationResponse'

        let(:user) { create(:user) }
        let!(:evaluation) { create(:evaluation, user:) }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
        let(:id) { evaluation.id }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }
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
