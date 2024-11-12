class Evaluation < ApplicationRecord
  belongs_to :user

  has_many :sum_scores, class_name: 'EffectivenessScores::Sum', dependent: :destroy
  has_many :min_scores, class_name: 'EffectivenessScores::Min', dependent: :destroy
  has_many :max_scores, class_name: 'EffectivenessScores::Max', dependent: :destroy
  has_many :weight_scores, class_name: 'EffectivenessScores::Weight', dependent: :destroy
  has_many :desired_scores, class_name: 'EffectivenessScores::Desired', dependent: :destroy
  has_many :term_value_preferences, class_name: 'EffectivenessScores::TermValuePreference', dependent: :destroy
end
