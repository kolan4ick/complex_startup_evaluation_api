require 'rails_helper'

RSpec.describe 'Evaluations', type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

  describe 'GET /index' do
    context 'when user is signed in' do
      let(:user) { create(:user) }
      let!(:evaluation) { create(:evaluation, user:) }

      before do
        get api_v1_evaluations_path, headers: Devise::JWT::TestHelpers.auth_headers(headers, user)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns evaluations' do
        expect(response.parsed_body).to match_array([EvaluationSerializer.render_as_json(evaluation)])
      end
    end

    context 'when user is not signed in' do
      before do
        get api_v1_evaluations_path
      end

      it 'returns a 401 error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /show' do
    context 'when user is signed in' do
      let(:user) { create(:user) }
      let!(:evaluation) { create(:evaluation, user:) }

      before do
        get api_v1_evaluation_path(evaluation), headers: Devise::JWT::TestHelpers.auth_headers(headers, user)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the evaluation' do
        expect(response.parsed_body).to eq(EvaluationSerializer.render_as_json(evaluation))
      end
    end

    context 'when user is not signed in' do
      let!(:evaluation) { create(:evaluation) }

      before do
        get api_v1_evaluation_path(evaluation)
      end

      it 'returns a 401 error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create' do
    let(:user) { create(:user) }
    let(:evaluation_params) do
      build(:evaluation)
      {
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
        risk_financial_scores_attributes: attributes_for_list(:risk_financial_score, 5),
        risk_investment_scores_attributes: attributes_for_list(:risk_investment_score, 5),
        risk_operational_scores_attributes: attributes_for_list(:risk_operational_score, 9),
        risk_innovation_activity_scores_attributes: attributes_for_list(:risk_innovation_activity_score, 5),
        team_stability_scores_attributes: attributes_for_list(:team_stability_score, 2),
        team_professional_competency_scores_attributes: attributes_for_list(:team_professional_competency_score, 5),
        team_professional_activity_scores_attributes: attributes_for_list(:team_professional_activity_score, 4),
        feasibility_linguistic: :high
      }
    end

    context 'when user is signed in' do
      before do
        post api_v1_evaluations_path, headers: Devise::JWT::TestHelpers.auth_headers(headers, user),
                                      params: { evaluation: evaluation_params }.to_json
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'creates an evaluation' do
        expect(Evaluation.count).to eq(1)
      end
    end

    context 'when user is not signed in' do
      before do
        post api_v1_evaluations_path, params: { evaluation: evaluation_params }.to_json, headers: headers
      end

      it 'returns a 401 error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
