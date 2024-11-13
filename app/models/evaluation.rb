# frozen_string_literal: true

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

class Evaluation < ApplicationRecord
  include Effectiveness::Evaluable
  include Risk::Evaluable

  belongs_to :user
end
