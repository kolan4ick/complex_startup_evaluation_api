module FinancingFeasibility
  class Evaluator
    K = 0.9 # TODO: Should be retrieved from user's preferences
    LINGUISTIC = {
      high: K * (2.0 / 9.0),
      above_average: K * (7.0 / 9.0),
      average: K * (4.0 / 9.0),
      low: K * (5.0 / 9.0),
      very_low: K * (3.0 / 2.0)
    }.freeze # TODO: Should be retrieved from user's preferences
    DELTA = 0.5 # TODO: Should be retrieved from user's preferences

    def initialize(effectiveness:, risk:, team:, linguistic: :high)
      @effectiveness = effectiveness
      @risk = risk
      @team = team
      @linguistic = linguistic
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

      theta_evaluation > 1.0 ? 1.0 - theta_evaluation : theta_evaluation
    end

    def calculate_membership(cone_shaped_membership)
      if cone_shaped_membership.negative?
        0
      elsif cone_shaped_membership >= 0 && cone_shaped_membership < 1.0
        cone_shaped_membership**LINGUISTIC[@linguistic]
      else
        1
      end
    end

    def theta
      Math.sqrt((@effectiveness - 1.0)**2 + (@risk - 1.0)**2 + (@team - 1.0)**2) / 3.0
    end

    def calculate_triangle_membership(membership) # rubocop:disable Metrics
      return 1 if membership <= left_boundary || membership >= right_boundary
      return calculate_membership_values(membership, 3, 2, 1) if in_range?(membership, left_boundary, middle_left)
      return calculate_membership_values(membership, 4, 3, 2) if in_range?(membership, middle_left, middle)
      return calculate_membership_values(membership, 5, 4, 3) if in_range?(membership, middle, middle_right)
      return calculate_membership_values(membership, 6, 5, 4) if in_range?(membership, middle_right, right_boundary)

      1 if membership > right_boundary
    end

    def left_boundary
      DELTA - (DELTA / 2.0)
    end

    def middle_left
      DELTA - (DELTA / 4.0)
    end

    def middle
      DELTA
    end

    def middle_right
      DELTA + (DELTA / 4.0)
    end

    def right_boundary
      DELTA + (DELTA / 2.0)
    end

    def in_range?(membership, lower, upper)
      membership > lower && membership <= upper
    end

    def calculate_membership_values(membership, upper_multiplier, lower_multiplier, order)
      res1 = ((upper_multiplier * DELTA) - (4 * membership)) / DELTA
      res2 = ((4 * membership) - (lower_multiplier * DELTA)) / DELTA
      [
        { value: res1, linguistic: linguistic_valuation(order) },
        { value: res2, linguistic: linguistic_valuation(order + 1) }
      ]
    end

    def linguistic_valuation(order) # rubocop:disable Metrics/MethodLength
      case order
      when 1
        'дуже низький рівень доцільності фінансування проекту'
      when 2
        'низький рівень доцільності фінансування проекту'
      when 3
        'середній рівень доцільності фінансування проекту'
      when 4
        'високий рівень доцільності фінансування проекту'
      when 5
        'дуже високий рівень доцільності фінансування проекту'
      else
        'невизначений рівень доцільності фінансування проекту'
      end
    end
  end
end
