class EffectivenessScore < ApplicationRecord
  belongs_to :evaluation

  validates :evaluation, presence: true
end
