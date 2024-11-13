# == Schema Information
#
# Table name: evaluations
#
#  id                               :bigint           not null, primary key
#  team_competencies                :integer
#  team_competencies_and_experience :integer
#  team_leaders_competencies        :integer
#  team_professional_activity       :integer
#  team_stability                   :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  user_id                          :bigint           not null
#
# Indexes
#
#  index_evaluations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :evaluation do
    user
    team_competencies { 1 }
    team_competencies_and_experience { 1 }
    team_leaders_competencies { 1 }
    team_professional_activity { 1 }
    team_stability { 1 }

    after(:build) do |evaluation|
      evaluation.effectiveness_sum_scores = build_list(:effectiveness_sum_score, 5, evaluation:)
      evaluation.effectiveness_min_scores = build_list(:effectiveness_min_score, 5, evaluation:)
      evaluation.effectiveness_max_scores = build_list(:effectiveness_max_score, 5, evaluation:)
      evaluation.effectiveness_desired_scores = build_list(:effectiveness_desired_score, 5, evaluation:)
      evaluation.effectiveness_weight_scores = build_list(:effectiveness_weight_score, 5, evaluation:)

      evaluation.risk_financial_scores = build_list(:risk_financial_score, 5, evaluation:)
      evaluation.risk_investment_scores = build_list(:risk_investment_score, 5, evaluation:)
      evaluation.risk_operational_scores = build_list(:risk_operational_score, 9, evaluation:)
      evaluation.risk_innovation_activity_scores = build_list(:risk_innovation_activity_score, 5, evaluation:)

      evaluation.team_stability_scores = build_list(:team_stability_score, 2, evaluation:)
      evaluation.team_professional_competency_scores = build_list(:team_professional_competency_score, 5, evaluation:)
      evaluation.team_professional_activity_scores = build_list(:team_professional_activity_score, 4, evaluation:)
    end
  end
end
