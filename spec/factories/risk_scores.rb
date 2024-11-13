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
FactoryBot.define do
  factory :risk_score do
    linguistic { 'ВС' }
    authenticity { 0.5 }
    evaluation

    factory :risk_financial_score, class: 'RiskScores::Financial'
    factory :risk_investment_score, class: 'RiskScores::Investment'
    factory :risk_operational_score, class: 'RiskScores::Operational'
    factory :risk_innovation_activity_score, class: 'RiskScores::InnovationActivity'
  end
end
