require 'rails_helper'

RSpec.describe EffectivenessScore, type: :model do
  describe 'associations' do
    it { should belong_to(:evaluation) }
  end

  describe 'validations' do
    it { should validate_presence_of(:evaluation) }
  end
end
