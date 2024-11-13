require 'rails_helper'

RSpec.describe TeamScoreSerializer do
  let(:user) { create(:user) }
  let(:evaluation) { create(:evaluation, user:) }
  let(:team_score) { create(:team_score, evaluation:) }

  context 'checking JSON' do
    context 'default' do
      subject { described_class.render_as_hash(team_score) }

      let(:expectation) do
        {
          id: team_score.id,
          order: team_score.order,
          linguistic: team_score.linguistic,
          confidence: team_score.confidence,
          weight: team_score.weight,
          created_at: team_score.created_at,
          updated_at: team_score.updated_at
        }
      end

      it 'gives a valid JSON' do
        expect(subject).to eq(expectation)
      end
    end
  end
end
