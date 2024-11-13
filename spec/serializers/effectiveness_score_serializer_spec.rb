require 'rails_helper'

RSpec.describe EffectivenessScoreSerializer do
  let(:user) { create(:user) }
  let(:evaluation) { create(:evaluation, user:) }
  let(:effectiveness_score) { create(:effectiveness_score, evaluation:) }

  context 'checking JSON' do
    context 'default' do
      subject { described_class.render_as_hash(effectiveness_score) }

      let(:expectation) do
        {
          id: effectiveness_score.id,
          order: effectiveness_score.order,
          value: effectiveness_score.value,
          created_at: effectiveness_score.created_at,
          updated_at: effectiveness_score.updated_at
        }
      end

      it 'gives a valid JSON' do
        expect(subject).to eq(expectation)
      end
    end

    context 'extended' do
      subject { described_class.render_as_hash(effectiveness_score, view: :extended) }

      let(:expectation) do
        {
          id: effectiveness_score.id,
          order: effectiveness_score.order,
          value: effectiveness_score.value,
          evaluation: {
            id: evaluation.id,
            user: {
              id: user.id,
              name: user.name,
              email: user.email,
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
            created_at: evaluation.created_at,
            updated_at: evaluation.updated_at
          },
          created_at: effectiveness_score.created_at,
          updated_at: effectiveness_score.updated_at
        }
      end

      it 'gives a valid JSON' do
        expect(subject).to eq(expectation)
      end
    end
  end
end
