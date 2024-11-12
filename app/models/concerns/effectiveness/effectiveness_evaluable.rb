# frozen_string_literal: true

module Effectiveness
  module EffectivenessEvaluable
    extend ActiveSupport::Concern

    included do
      has_many :sum_scores, class_name: 'EffectivenessScores::Sum', dependent: :destroy
      has_many :min_scores, class_name: 'EffectivenessScores::Min', dependent: :destroy
      has_many :max_scores, class_name: 'EffectivenessScores::Max', dependent: :destroy
      has_many :desired_scores, class_name: 'EffectivenessScores::Desired', dependent: :destroy
      has_many :weight_scores, class_name: 'EffectivenessScores::Weight', dependent: :destroy
    end

    def evaluate
      EffectivenessEvaluator.new(
        sum_scores:,
        min_scores:,
        max_scores:,
        desired_scores:,
        desired_terms:,
        weight_scores:
      ).evaluate
    end
  end
end
