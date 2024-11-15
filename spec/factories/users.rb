# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  adjustment_delta       :float
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  feasibility_threshold  :float
#  jti                    :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    name { 'Test name' }
    sequence(:email) { |n| "name#{n}@example.com" }
    feasibility_threshold { 0.6 }
    adjustment_delta { 0.2 }
    password { 'topsecret' }
    password_confirmation { password }
  end
end
