# frozen_string_literal: true

module Team
  class Evaluator
    TERMS = [2.0, 5.0, 8.0, 10.0].freeze

    class TeamAssessment
      include Enumerable

      attr_accessor :linguistic, :confidence, :weights, :weight, :team, :leaders

      def initialize(**args)
        @linguistic, @confidence, @weights = args[:term].pluck(:linguistic, :confidence, :weight).transpose

        @confidence.map!(&:to_f)
        @weights.map!(&:to_f)

        @weight = args[:weight].to_f
        @team = args[:team].to_f
        @leaders = args[:leaders].to_f
      end

      def characteristics
        as = { 'low' => TERMS[0], 'below_middle' => TERMS[1], 'middle' => TERMS[2], 'high' => TERMS[3] }

        @linguistic.zip(@confidence, @weights).map do |linguistic, confidence|
          as[linguistic] * confidence
        end
      end

      def membership # rubocop:disable Metrics/MethodLength
        chars = characteristics

        chars.map do |char|
          if char <= 0
            0
          elsif char > 1 && char <= 5
            0.02 * (char**2)
          elsif char > 5 && char < 10
            1 - 0.02 * ((10 - char)**2)
          else
            1
          end
        end
      end
    end

    def initialize(**args)
      @k1 = TeamAssessment.new(term: args[:team_stability_scores], weight: args[:team_competencies])
      @k2 = TeamAssessment.new(term: args[:team_professional_competency_scores], team: args[:team],
                               leaders: args[:leaders], weight: args[:team_competencies_and_experience])
      @k3 = TeamAssessment.new(term: args[:team_professional_activity_scores],
                               weight: args[:team_professional_activity])
    end

    def evaluate
      membership = [@k1, @k2, @k3].map(&:membership)

      g_p_p = grouped_postsynaptic_potential(membership)

      p_p = postsynaptic_potential(*g_p_p)

      defuzzification = p_p.sum

      rate = rating(defuzzification)

      {
        membership:,
        defuzzification:,
        rate:
      }
    end

    def grouped_postsynaptic_potential(membership) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      z1 = (1 / @k1.weights.sum) * (membership[0][0] * @k1.weights[0] + membership[0][1] * @k1.weights[1])

      z21 = (1 / (@k2.weights[0] + @k2.weights[1])) * (membership[1][0] * @k2.weights[0] +
        membership[1][1] * @k2.weights[1])

      z22 = (1 / (@k2.weights[2] + @k2.weights[3] + @k2.weights[4])) * (
        membership[1][2] * @k2.weights[2] + membership[1][3] *
          @k2.weights[3] + membership[1][4] * @k2.weights[4]
      )

      z2 = (1 / (@k2.leaders + @k2.team)) * (z21 * @k2.leaders + z22 * @k2.team)

      z3 = (1 / @k3.weights.sum) * (membership[2][0] * @k3.weights[0] + membership[2][1] *
        @k3.weights[1] + membership[2][2] * @k3.weights[2] + membership[2][3] * @k3.weights[3])

      [z1, z2, z3]
    end

    def postsynaptic_potential(potential1, potential2, potential3) # rubocop:disable Metrics/AbcSize
      w1 = (@k1.weight / (@k1.weight + @k2.weight + @k3.weight)) * potential1
      w2 = (@k2.weight / (@k1.weight + @k2.weight + @k3.weight)) * potential2
      w3 = (@k3.weight / (@k1.weight + @k2.weight + @k3.weight)) * potential3

      [w1, w2, w3]
    end

    def rating(defuzzification) # rubocop:disable Metrics/MethodLength
      case defuzzification
      when 0.0..0.21
        I18n.t('api.evaluator.team.rating.low')
      when 0.22..0.37
        I18n.t('api.evaluator.team.rating.below_avg')
      when 0.38..0.67
        I18n.t('api.evaluator.team.rating.avg')
      when 0.68..0.87
        I18n.t('api.evaluator.team.rating.above_avg')
      else
        I18n.t('api.evaluator.team.rating.high')
      end
    end
  end
end
