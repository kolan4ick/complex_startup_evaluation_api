# frozen_string_literal: true

module FinancingFeasibility
  module Evaluable
    def evaluate_financing_feasibility(effectiveness, risk, team)
      current_feasibility_level = user.feasibility_levels.where(linguistic: feasibility_linguistic).first

      Evaluator.new(
        effectiveness: effectiveness,
        risk: risk,
        team: team,
        feasibility_level: current_feasibility_level.value,
        adjustment_delta: user.adjustment_delta
      ).evaluate
    end
  end
end
