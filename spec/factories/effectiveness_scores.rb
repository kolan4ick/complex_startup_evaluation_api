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

FactoryBot.define do
  factory :effectiveness_score do
    value { 0.2 }
    sequence(:order) { |n| n }
    evaluation

    factory :effectiveness_sum_score, class: 'EffectivenessScores::Sum'
    factory :effectiveness_min_score, class: 'EffectivenessScores::Min'
    factory :effectiveness_max_score, class: 'EffectivenessScores::Max'
    factory :effectiveness_desired_score, class: 'EffectivenessScores::Desired'
    factory :effectiveness_weight_score, class: 'EffectivenessScores::Weight'
    factory :effectiveness_desired_term_score, class: 'EffectivenessScores::DesiredTerm' do
      value { 3 }
    end
  end
end
