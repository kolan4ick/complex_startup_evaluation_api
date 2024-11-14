# == Schema Information
#
# Table name: feasibility_levels
#
#  id         :bigint           not null, primary key
#  linguistic :integer          default("very_low")
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

  enum :linguistic, { very_low: 1, low: 2, middle: 3, high: 4, very_high: 5 }
end
