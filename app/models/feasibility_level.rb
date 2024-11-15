# == Schema Information
#
# Table name: feasibility_levels
#
#  id         :bigint           not null, primary key
#  linguistic :integer          default("high")
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
end
