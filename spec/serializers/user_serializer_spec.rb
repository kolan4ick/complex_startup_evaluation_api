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
          adjustment_delta: user.adjustment_delta,
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
          adjustment_delta: user.adjustment_delta,
          feasibility_levels: user.feasibility_levels.map do |f_l|
            {
              id: f_l.id,
              title: f_l.title,
              linguistic: f_l.linguistic,
              value: f_l.value,
              created_at: f_l.created_at,
              updated_at: f_l.updated_at
            }
          end,
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
