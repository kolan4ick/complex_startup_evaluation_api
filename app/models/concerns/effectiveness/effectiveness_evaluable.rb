# frozen_string_literal: true

module Effectiveness
  module EffectivenessEvaluable
    extend ActiveSupport::Concern

    included do
      has_many :effectiveness_sum_scores, class_name: 'EffectivenessScores::Sum', dependent: :destroy
      has_many :effectiveness_min_scores, class_name: 'EffectivenessScores::Min', dependent: :destroy
      has_many :effectiveness_max_scores, class_name: 'EffectivenessScores::Max', dependent: :destroy
      has_many :effectiveness_desired_scores, class_name: 'EffectivenessScores::Desired', dependent: :destroy
      has_many :effectiveness_weight_scores, class_name: 'EffectivenessScores::Weight', dependent: :destroy

      accepts_nested_attributes_for :effectiveness_sum_scores, :effectiveness_min_scores, :effectiveness_max_scores,
                                    :effectiveness_desired_scores, :effectiveness_weight_scores
    end

    def evaluate
      EffectivenessEvaluator.new(
        sum_scores: effectiveness_sum_scores.order(:order).pluck(:value),
        min_scores: effectiveness_min_scores.order(:order).pluck(:value),
        max_scores: effectiveness_max_scores.order(:order).pluck(:value),
        desired_scores: effectiveness_desired_scores.order(:order).pluck(:value),
        desired_terms: [2, 2, 2, 3, 5], # TODO: This should be dynamic in the future
        weight_scores: effectiveness_weight_scores.order(:order).pluck(:value)
      ).evaluate
    end
  end
end
