# == Schema Information
#
# Table name: risk_scores
#
#  id            :bigint           not null, primary key
#  authenticity  :float
#  linguistic    :string
#  order         :integer
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  evaluation_id :bigint           not null
#
# Indexes
#
#  index_risk_scores_on_evaluation_id  (evaluation_id)
#
# Foreign Keys
#
#  fk_rails_...  (evaluation_id => evaluations.id)
#
require 'rails_helper'

RSpec.describe RiskScore, type: :model do
  describe 'associations' do
    it { should belong_to(:evaluation) }
  end
end
