# frozen_string_literal: true

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
module RiskScores
  class Operational < RiskScore
  end
end
