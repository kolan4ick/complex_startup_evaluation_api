require 'rails_helper'

RSpec.describe FeasibilityLevelSerializer do
  let(:user) { create(:user) }
  let(:feasibility_level) { create(:feasibility_level, user:) }

  context 'checking JSON' do
    context 'default' do
      subject { described_class.render_as_hash(feasibility_level) }

      let(:expectation) do
        {
          id: feasibility_level.id,
          title: feasibility_level.title,
          linguistic: feasibility_level.linguistic,
          value: feasibility_level.value,
          created_at: feasibility_level.created_at,
          updated_at: feasibility_level.updated_at
        }
      end

      it 'gives a valid JSON' do
        expect(subject).to eq(expectation)
      end
    end
  end
end
