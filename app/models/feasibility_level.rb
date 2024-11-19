# == Schema Information
#
# Table name: feasibility_levels
#
#  id         :bigint           not null, primary key
#  linguistic :integer          default("high")
#  order      :integer          default(1)
#  title      :string
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_feasibility_levels_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class FeasibilityLevel < ApplicationRecord
  belongs_to :user

  enum :linguistic, { high: 1, above_middle: 2, middle: 3, low: 4, very_low: 5 }

  validates :linguistic, presence: true
  validates :value, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1 }
end
