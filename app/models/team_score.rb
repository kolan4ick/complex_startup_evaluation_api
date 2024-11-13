# == Schema Information
#
# Table name: team_scores
#
#  id            :bigint           not null, primary key
#  confidence    :float
#  linguistic    :string
#  order         :integer
#  type          :string
#  weight        :float
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
end
