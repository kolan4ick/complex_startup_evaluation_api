# frozen_string_literal: true

module FinancingFeasibility
  module Evaluable
    def evaluate_financing_feasibility(effectiveness, risk, team)
      current_feasibility_level = user.feasibility_levels.where(linguistic: feasibility_linguistic).first

      feasibility_level = current_feasibility_level.value * user.feasibility_threshold

      Evaluator.new(
        effectiveness: effectiveness,
        risk: risk,
        team: team,
        feasibility_level: feasibility_level,
        adjustment_delta: user.adjustment_delta
      ).evaluate
    end
  end
end
