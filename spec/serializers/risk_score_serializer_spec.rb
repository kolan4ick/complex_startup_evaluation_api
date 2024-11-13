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
  end
end
