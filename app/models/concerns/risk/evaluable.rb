# frozen_string_literal: true

module Risk
  module Evaluable
    extend ActiveSupport::Concern

    included do
      has_many :risk_financial_scores, class_name: 'RiskScores::Financial', dependent: :destroy
      has_many :risk_innovation_activity_scores, class_name: 'RiskScores::InnovationActivity', dependent: :destroy
      has_many :risk_investment_scores, class_name: 'RiskScores::Investment', dependent: :destroy
      has_many :risk_operational_scores, class_name: 'RiskScores::Operational', dependent: :destroy

      accepts_nested_attributes_for :risk_financial_scores, :risk_innovation_activity_scores,
                                    :risk_investment_scores, :risk_operational_scores
    end

    def evaluate_risk
      Risk::Evaluator.new(
        financial_scores: risk_financial_scores.order(:order),
        innovation_activity_scores: risk_innovation_activity_scores.order(:order),
        investment_scores: risk_investment_scores.order(:order),
        operational_scores: risk_operational_scores.order(:order)
      ).evaluate
    end
  end
end
