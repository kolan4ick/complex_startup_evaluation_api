# frozen_string_literal: true

module FinancingFeasibility
  module Evaluable
    def evaluate_financing_feasibility(effectiveness, risk, team)
      Evaluator.new(
        effectiveness:,
        risk:,
        team:
      ).evaluate
    end
  end
end
