# frozen_string_literal: true

# == Schema Information
#
# Table name: evaluations
#
#  id                               :bigint           not null, primary key
#  feasibility_linguistic           :integer          default("high")
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
class Evaluation < ApplicationRecord
  include Effectiveness::Evaluable
  include Risk::Evaluable
  include Team::Evaluable
  include FinancingFeasibility::Evaluable

  enum :feasibility_linguistic, { high: 1, above_middle: 2, middle: 3, low: 4, very_low: 5 }

  belongs_to :user

  validates :feasibility_linguistic, presence: true
  validates :team_competencies, :team_competencies_and_experience, :team_leaders_competencies,
            :team_professional_activity, :team_stability, presence: true,
                                                          numericality: { greater_than: 0, less_than_or_equal_to: 10 }
end
