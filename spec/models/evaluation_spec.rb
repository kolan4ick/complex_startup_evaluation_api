# == Schema Information
#
# Table name: evaluations
#
#  id                               :bigint           not null, primary key
#  feasibility_linguistic           :integer          default("very_low")
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
end
