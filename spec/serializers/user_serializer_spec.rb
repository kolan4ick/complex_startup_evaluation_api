require 'rails_helper'

RSpec.describe UserSerializer do
  let(:user) { create(:user) }

  subject { described_class.render_as_hash(user) }

  context 'checking JSON' do
    let(:expectation) do
      {
        id: user.id,
        name: user.name,
        evaluations: user.evaluations,
        email: user.email,
        created_at: user.created_at,
        updated_at: user.updated_at
      }
    end

    it 'gives a valid JSON' do
      expect(subject).to eq(expectation)
    end
  end
end