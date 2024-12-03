require 'rails_helper'

RSpec.describe EvaluationSerializer do
  let(:user) { create(:user) }
  let(:evaluation) { create(:evaluation, user:) }

  subject { described_class.render_as_hash(evaluation) }

  context 'checking JSON' do
    let(:expectation) do
      {
        id: evaluation.id,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          adjustment_delta: user.adjustment_delta,
          created_at: user.created_at,
          updated_at: user.updated_at
        },
        effectiveness_sum_scores: evaluation.effectiveness_sum_scores.map do |score|
          {
            id: score.id,
            value: score.value,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        effectiveness_min_scores: evaluation.effectiveness_min_scores.map do |score|
          {
            id: score.id,
            value: score.value,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        effectiveness_max_scores: evaluation.effectiveness_max_scores.map do |score|
          {
            id: score.id,
            value: score.value,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        effectiveness_desired_scores: evaluation.effectiveness_desired_scores.map do |score|
          {
            id: score.id,
            value: score.value,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        effectiveness_weight_scores: evaluation.effectiveness_weight_scores.map do |score|
          {
            id: score.id,
            value: score.value,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        effectiveness_desired_term_scores: evaluation.effectiveness_desired_term_scores.map do |score|
          {
            id: score.id,
            value: score.value,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        risk_financial_scores: evaluation.risk_financial_scores.map do |score|
          {
            id: score.id,
            linguistic: score.linguistic,
            authenticity: score.authenticity,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        risk_innovation_activity_scores: evaluation.risk_innovation_activity_scores.map do |score|
          {
            id: score.id,
            linguistic: score.linguistic,
            authenticity: score.authenticity,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        risk_investment_scores: evaluation.risk_investment_scores.map do |score|
          {
            id: score.id,
            linguistic: score.linguistic,
            authenticity: score.authenticity,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        risk_operational_scores: evaluation.risk_operational_scores.map do |score|
          {
            id: score.id,
            linguistic: score.linguistic,
            authenticity: score.authenticity,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        team_professional_activity_scores: evaluation.team_professional_activity_scores.map do |score|
          {
            id: score.id,
            linguistic: score.linguistic,
            confidence: score.confidence,
            weight: score.weight,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        team_professional_competency_scores: evaluation.team_professional_competency_scores.map do |score|
          {
            id: score.id,
            linguistic: score.linguistic,
            confidence: score.confidence,
            weight: score.weight,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        team_stability_scores: evaluation.team_stability_scores.map do |score|
          {
            id: score.id,
            linguistic: score.linguistic,
            confidence: score.confidence,
            weight: score.weight,
            order: score.order,
            created_at: score.created_at,
            updated_at: score.updated_at
          }
        end,
        team_competencies: evaluation.team_competencies,
        team_competencies_and_experience: evaluation.team_competencies_and_experience,
        team_leaders_competencies: evaluation.team_leaders_competencies,
        team_professional_activity: evaluation.team_professional_activity,
        team_stability: evaluation.team_stability,
        feasibility_linguistic: evaluation.feasibility_linguistic,
        created_at: evaluation.created_at,
        updated_at: evaluation.updated_at
      }
    end

    it 'gives a valid JSON' do
      expect(subject).to eq(expectation)
    end
  end
end
