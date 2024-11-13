# == Schema Information
#
# Table name: evaluations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
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

    after(:build) do |evaluation|
      evaluation.effectiveness_sum_scores = build_list(:effectiveness_sum_score, 5, evaluation:)
      evaluation.effectiveness_min_scores = build_list(:effectiveness_min_score, 5, evaluation:)
      evaluation.effectiveness_max_scores = build_list(:effectiveness_max_score, 5, evaluation:)
      evaluation.effectiveness_desired_scores = build_list(:effectiveness_desired_score, 5, evaluation:)
      evaluation.effectiveness_weight_scores = build_list(:effectiveness_weight_score, 5, evaluation:)
    end
  end
end
