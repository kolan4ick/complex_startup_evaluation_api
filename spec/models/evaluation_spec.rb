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

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  describe 'associations' do
    it { should have_many :sum_scores }
    it { should have_many :max_scores }
    it { should have_many :min_scores }
    it { should have_many :desired_scores }
    it { should have_many :weight_scores }
  end
end
