# == Schema Information
#
# Table name: risk_scores
#
#  id            :bigint           not null, primary key
#  authenticity  :float
#  linguistic    :integer          default("low")
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
class RiskScore < ApplicationRecord
  belongs_to :evaluation

  enum :linguistic, {
    low: 1,
    below_middle: 2,
    middle: 3,
    above_middle: 4,
    high: 5
  }

  validates :linguistic, presence: true
  validates :authenticity, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1 }
end
