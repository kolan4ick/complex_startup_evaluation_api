require 'rails_helper'

RSpec.describe UserSerializer do
  let(:user) { create(:user) }

  context 'checking JSON' do
    context 'default' do
      subject { described_class.render_as_hash(user) }

      let(:expectation) do
        {
          id: user.id,
          name: user.name,
          email: user.email,
          created_at: user.created_at,
          updated_at: user.updated_at
        }
      end

      it 'gives a valid JSON' do
        expect(subject).to eq(expectation)
      end
    end

    context 'extended' do
      subject { described_class.render_as_hash(user, view: :extended) }

      let(:expectation) do
        {
          id: user.id,
          name: user.name,
          email: user.email,
          evaluations: [],
          created_at: user.created_at,
          updated_at: user.updated_at
        }
      end

      it 'gives a valid JSON' do
        expect(subject).to eq(expectation)
      end
    end
  end
end
