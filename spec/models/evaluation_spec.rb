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
