require 'rails_helper'

RSpec.describe EffectivenessScoreSerializer do
  let(:effectiveness_score) { create(:effectiveness_score, evaluation: create(:evaluation)) }

  subject { described_class.render_as_hash(effectiveness_score) }

  context 'checking JSON' do
    let(:expectation) do
      {
        id: effectiveness_score.id,
        evaluation: effectiveness_score.evaluation,
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
end
