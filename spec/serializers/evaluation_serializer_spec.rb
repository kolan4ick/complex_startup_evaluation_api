RSpec.describe EvaluationSerializer do
  let(:evaluation) { create(:evaluation) }

  subject { described_class.render_as_hash(evaluation) }

  context 'checking JSON' do
    let(:expectation) do
      {
        id: evaluation.id,
        user: evaluation.user,
        sum_scores: evaluation.sum_scores,
        min_scores: evaluation.min_scores,
        max_scores: evaluation.max_scores,
        desired_scores: evaluation.desired_scores,
        weight_scores: evaluation.weight_scores
      }
    end

    it 'gives a valid JSON' do
      expect(subject).to eq(expectation)
    end
  end
end
