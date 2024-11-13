require 'rails_helper'

RSpec.describe RiskScoreSerializer do
  let(:user) { create(:user) }
  let(:evaluation) { create(:evaluation, user:) }
  let(:risk_score) { create(:risk_score, evaluation:) }

  context 'checking JSON' do
    context 'default' do
      subject { described_class.render_as_hash(risk_score) }

      let(:expectation) do
        {
          id: risk_score.id,
          order: risk_score.order,
          linguistic: risk_score.linguistic,
          authenticity: risk_score.authenticity,
          created_at: risk_score.created_at,
          updated_at: risk_score.updated_at
        }
      end

      it 'gives a valid JSON' do
        expect(subject).to eq(expectation)
      end
    end

    context 'extended' do
      subject { described_class.render_as_hash(risk_score, view: :extended) }

      let(:expectation) do
        {
          id: risk_score.id,
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
            created_at: evaluation.created_at,
            updated_at: evaluation.updated_at
          },
          order: risk_score.order,
          linguistic: risk_score.linguistic,
          authenticity: risk_score.authenticity,
          created_at: risk_score.created_at,
          updated_at: risk_score.updated_at
        }
      end

      it 'gives a valid JSON' do
        expect(subject).to eq(expectation)
      end
    end
  end
end
