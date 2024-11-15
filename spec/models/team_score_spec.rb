# == Schema Information
#
# Table name: team_scores
#
#  id            :bigint           not null, primary key
#  confidence    :float
#  linguistic    :string
#  order         :integer
#  type          :string
#  weight        :integer          default(1), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  evaluation_id :bigint           not null
#
# Indexes
#
#  index_team_scores_on_evaluation_id  (evaluation_id)
#
# Foreign Keys
#
#  fk_rails_...  (evaluation_id => evaluations.id)
#
require 'rails_helper'

RSpec.describe TeamScore, type: :model do
  describe 'associations' do
    it { should belong_to(:evaluation) }
  end

  describe 'validations' do
    it { should validate_presence_of(:linguistic) }
    it { should validate_presence_of(:confidence) }
    it { should validate_presence_of(:weight) }

    it { should validate_numericality_of(:confidence).is_greater_than(0).is_less_than_or_equal_to(1) }
    it { should validate_numericality_of(:weight).is_greater_than(0) }
  end
end
