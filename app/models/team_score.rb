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
class TeamScore < ApplicationRecord
  belongs_to :evaluation

  validates :linguistic, presence: true
  validates :confidence, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1 }
  validates :weight, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
end
