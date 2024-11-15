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

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  describe 'associations' do
    it { should have_many :effectiveness_sum_scores }
    it { should have_many :effectiveness_max_scores }
    it { should have_many :effectiveness_min_scores }
    it { should have_many :effectiveness_desired_scores }
    it { should have_many :effectiveness_weight_scores }
    it { should have_many :risk_financial_scores }
    it { should have_many :risk_innovation_activity_scores }
    it { should have_many :risk_investment_scores }
    it { should have_many :risk_operational_scores }
  end

  describe 'validations' do
    it { should validate_presence_of :feasibility_linguistic }
    it { should validate_presence_of :team_competencies }
    it { should validate_presence_of :team_competencies_and_experience }
    it { should validate_presence_of :team_leaders_competencies }
    it { should validate_presence_of :team_professional_activity }
    it { should validate_presence_of :team_stability }

    it { should validate_numericality_of(:team_competencies).is_greater_than(0).is_less_than_or_equal_to(10) }
    it {
      should validate_numericality_of(:team_competencies_and_experience).is_greater_than(0).is_less_than_or_equal_to(10)
    }
    it { should validate_numericality_of(:team_leaders_competencies).is_greater_than(0).is_less_than_or_equal_to(10) }
    it { should validate_numericality_of(:team_professional_activity).is_greater_than(0).is_less_than_or_equal_to(10) }
    it { should validate_numericality_of(:team_stability).is_greater_than(0).is_less_than_or_equal_to(10) }
  end
end
