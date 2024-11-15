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
FactoryBot.define do
  factory :feasibility_level do
    title { 'Some level' }
    value { 0.4 }
    linguistic { :high }
  end
end
