# frozen_string_literal: true

module Risk
  class Evaluator
    RISK_LEVELS = %w[Н НС С ВС В].freeze

    RISK_PERCENTAGE_LEVELS = {
      'Н' => [0.0, 20.0],
      'НС' => [20.0, 40.0],
      'С' => [40.0, 60.0],
      'ВС' => [60.0, 80.0],
      'В' => [80.0, 100.0]
    }.freeze

    class RiskAssessment
      include Enumerable

      attr_accessor :linguistic, :authenticity
      attr_reader :aggregated_assessment

      def initialize(term)
        @linguistic, @authenticity = term.pluck(:linguistic, :authenticity).transpose

        @aggregated_assessment = aggregate_assessment
      end

      def each
        return enum_for(:each) unless block_given?

        @linguistic.each_with_index do |linguistic, index|
          yield [linguistic, @authenticity[index]]
        end
      end

      # Aggregate the assessment
      # @return [String] aggregated assessment
      def aggregate_assessment
        RISK_LEVELS.each do |level|
          return level if @linguistic.count(level).to_f / @linguistic.size >= 0.6
        end

        'No matching risk level found'
      end

      # Aggregate reliability assessment
      # @return [Float] aggregated assessment
      def aggregate_reliability_assessment
        count_of_desired_term = @linguistic.count(@aggregated_assessment)

        modified_authenticity = @authenticity.reject.with_index do |_, idx|
          @linguistic[idx] != @aggregated_assessment
        end

        sum_of_desired_term = modified_authenticity.sum

        ((1.0 / count_of_desired_term) * sum_of_desired_term).to_f
      end

      # Estimate the term membership
      # @return [Hash] estimated membership
      def estimate_term_membership # rubocop:disable Metrics/AbcSize
        agg_rel_assess = aggregate_reliability_assessment

        a = RISK_PERCENTAGE_LEVELS[aggregated_assessment][0]
        b = RISK_PERCENTAGE_LEVELS[aggregated_assessment][1]

        x = if agg_rel_assess >= 0 && agg_rel_assess <= 0.5
              Math.sqrt(agg_rel_assess / 2) * (b - a) + a
            elsif agg_rel_assess > 0.5 && agg_rel_assess <= 1
              b - Math.sqrt((1 - agg_rel_assess) / 2) * (b - a)
            end || 0

        {
          x => x / 100.0
        }
      end
    end

    def initialize(**terms)
      @terms = terms.map { |_, term| RiskAssessment.new(term) }
    end

    # Evaluate the effectiveness of the startup
    def evaluate
      # First step
      res_term_estimate = @terms.map do |el|
        { k: el, aggregated_assessment: el.aggregated_assessment }
      end

      # Second step
      aggregated_reliability_assessment = @terms.map do |el|
        { k: el, aggregate_reliability_assessment: el.aggregate_reliability_assessment }
      end

      # Third step
      estimated_membership = @terms.map(&:estimate_term_membership)

      # Fourth step
      aggregated_membership = aggregated_membership(estimated_membership)

      # Fifth step
      security_level = security_level(aggregated_membership)

      {
        res_term_estimate:,
        aggregated_reliability_assessment:,
        estimated_membership:,
        aggregated_membership:,
        security_level:
      }
    end

    private

    # Determine the security level
    # @param aggregated_membership [Float] aggregated membership
    # @return [String] security level
    def security_level(aggregated_membership) # rubocop:disable Metrics/MethodLength
      case aggregated_membership
      when 0..0.21
        'Рівень безпеки фінансування проєкту низький'
      when 0.21..0.36
        'Рівень безпеки фінансування проєкту нижче середнього'
      when 0.36..0.67
        'Рівень безпеки фінансування проєкту середній'
      when 0.67..0.87
        'Рівень безпеки фінансування проєкту вище середнього'
      when 0.87..1
        'Рівень безпеки фінансування проєкту високий'
      else
        'Рівень безпеки фінансування проєкту не визначено'
      end
    end

    # Aggregate the membership
    # @param estimated_membership [Array] estimated membership
    # @return [Float] aggregated membership
    def aggregated_membership(estimated_membership)
      ((1.0 / 4.0) * estimated_membership.map { |membership| 1.0 - membership.first[1] }.sum).to_f
    end
  end
end
