# frozen_string_literal: true

module Effectiveness
  module Evaluable
    extend ActiveSupport::Concern

    included do
      has_many :effectiveness_sum_scores, class_name: 'EffectivenessScores::Sum', dependent: :destroy
      has_many :effectiveness_min_scores, class_name: 'EffectivenessScores::Min', dependent: :destroy
      has_many :effectiveness_max_scores, class_name: 'EffectivenessScores::Max', dependent: :destroy
      has_many :effectiveness_desired_scores, class_name: 'EffectivenessScores::Desired', dependent: :destroy
      has_many :effectiveness_weight_scores, class_name: 'EffectivenessScores::Weight', dependent: :destroy
      has_many :effectiveness_desired_term_scores, class_name: 'EffectivenessScores::DesiredTerm', dependent: :destroy

      accepts_nested_attributes_for :effectiveness_sum_scores, :effectiveness_min_scores, :effectiveness_max_scores,
                                    :effectiveness_desired_scores, :effectiveness_weight_scores,
                                    :effectiveness_desired_term_scores
    end

    def evaluate_effectiveness # rubocop:disable Metrics
      Evaluator.new(
        sum_scores: effectiveness_sum_scores.order(:order).pluck(:value),
        min_scores: effectiveness_min_scores.order(:order).pluck(:value),
        max_scores: effectiveness_max_scores.order(:order).pluck(:value),
        desired_scores: effectiveness_desired_scores.order(:order).pluck(:value),
        desired_terms: effectiveness_desired_term_scores.order(:order).pluck(:value),
        weight_scores: effectiveness_weight_scores.order(:order).pluck(:value)
      ).evaluate
    end
  end
end
