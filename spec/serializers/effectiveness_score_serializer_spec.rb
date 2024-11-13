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
  end
end
