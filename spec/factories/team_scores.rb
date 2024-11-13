# == Schema Information
#
# Table name: team_scores
#
#  id            :bigint           not null, primary key
#  authenticity  :float
#  linguistic    :string
#  order         :integer
#  type          :string
#  weight        :integer
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
    linguistic { "MyString" }
    authenticity { 1.5 }
    weight { 1 }
    order { 1 }
    evaluation { nil }
    type { "" }
  end
end
