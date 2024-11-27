module FinancingFeasibility
  class Evaluator
    def initialize(**args)
      @effectiveness = args[:effectiveness]
      @risk = args[:risk]
      @team = args[:team]
      @adjustment_delta = args[:adjustment_delta]
      @feasibility_level = args[:feasibility_level]
    end

    def evaluate
      # First step
      cone_shaped_membership = calculate_cone_shaped_membership

      # Second step
      membership = calculate_membership(cone_shaped_membership)

      # Third step
      triangle_membership = calculate_triangle_membership(membership)

      { cone_shaped_membership:, membership:, triangle_membership: }
    end

    private

    def calculate_cone_shaped_membership
      theta_evaluation = theta

      theta_evaluation < 1.0 ? 1.0 - theta_evaluation : 0
    end

    def calculate_membership(cone_shaped_membership)
      if cone_shaped_membership.negative?
        0
      elsif cone_shaped_membership >= 0 && cone_shaped_membership < 1.0
        cone_shaped_membership**@feasibility_level
      else
        1
      end
    end

    def theta
      Math.sqrt((@effectiveness - 1.0)**2 + (@risk - 1.0)**2 + (@team - 1.0)**2) / 3.0
    end

    def calculate_triangle_membership(membership) # rubocop:disable Metrics
      return [{ value: 1, linguistic: linguistic_valuation(1) }] if membership <= left_boundary
      return [{ value: 1, linguistic: linguistic_valuation(5) }] if membership >= right_boundary
      return calculate_membership_values(membership, 3, 2, 1) if in_range?(membership, left_boundary, middle_left)
      return calculate_membership_values(membership, 4, 3, 2) if in_range?(membership, middle_left, middle)
      return calculate_membership_values(membership, 5, 4, 3) if in_range?(membership, middle, middle_right)

      calculate_membership_values(membership, 6, 5, 4) if in_range?(membership, middle_right, right_boundary)
    end

    def left_boundary
      @adjustment_delta - (@adjustment_delta / 2.0)
    end

    def middle_left
      @adjustment_delta - (@adjustment_delta / 4.0)
    end

    def middle
      @adjustment_delta
    end

    def middle_right
      @adjustment_delta + (@adjustment_delta / 4.0)
    end

    def right_boundary
      @adjustment_delta + (@adjustment_delta / 2.0)
    end

    def in_range?(membership, lower, upper)
      membership > lower && membership <= upper
    end

    def calculate_membership_values(membership, upper_multiplier, lower_multiplier, order)
      res1 = ((upper_multiplier * @adjustment_delta) - (4 * membership)) / @adjustment_delta
      res2 = ((4 * membership) - (lower_multiplier * @adjustment_delta)) / @adjustment_delta
      [
        { value: res1, linguistic: linguistic_valuation(order) },
        { value: res2, linguistic: linguistic_valuation(order + 1) }
      ]
    end

    def linguistic_valuation(order) # rubocop:disable Metrics/MethodLength
      case order
      when 1
        I18n.t('api.evaluator.financing_feasibility.linguistic_valuation.very_low')
      when 2
        I18n.t('api.evaluator.financing_feasibility.linguistic_valuation.low')
      when 3
        I18n.t('api.evaluator.financing_feasibility.linguistic_valuation.medium')
      when 4
        I18n.t('api.evaluator.financing_feasibility.linguistic_valuation.high')
      when 5
        I18n.t('api.evaluator.financing_feasibility.linguistic_valuation.very_high')
      else
        I18n.t('api.evaluator.financing_feasibility.linguistic_valuation.undefined')
      end
    end
  end
end
