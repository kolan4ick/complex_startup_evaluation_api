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
FactoryBot.define do
  factory :team_score do
    linguistic { 'НС' }
    confidence { 0.5 }
    weight { 2 }
    evaluation

    factory :team_stability_score, class: 'TeamScores::Stability'
    factory :team_professional_competency_score, class: 'TeamScores::ProfessionalCompetency'
    factory :team_professional_activity_score, class: 'TeamScores::ProfessionalActivity'
  end
end
