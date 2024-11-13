# == Schema Information
#
# Table name: effectiveness_scores
#
#  id            :bigint           not null, primary key
#  order         :integer
#  type          :string
#  value         :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  evaluation_id :bigint           not null
#
# Indexes
#
#  index_effectiveness_scores_on_evaluation_id  (evaluation_id)
#
# Foreign Keys
#
#  fk_rails_...  (evaluation_id => evaluations.id)
#

require 'rails_helper'

RSpec.describe EffectivenessScore, type: :model do
  describe 'associations' do
    it { should belong_to(:evaluation) }
  end
end
