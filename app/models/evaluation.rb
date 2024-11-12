class Evaluation < ApplicationRecord
  include Effectiveness::EffectivenessEvaluable

  belongs_to :user
end
