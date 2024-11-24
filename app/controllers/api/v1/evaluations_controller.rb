module Api
  module V1
    class EvaluationsController < ApplicationController
      before_action :authenticate_user!

      def index # rubocop:disable Metrics/AbcSize
        page = params[:page] || 1
        per_page = params[:per_page] || 20
        reverse = params[:reverse] || false

        evaluations = current_user.evaluations.order(created_at: reverse ? :desc : :asc).page(page).per(per_page)

        render json: {
          evaluations: EvaluationSerializer.render_as_hash(evaluations),
          meta: {
            current_page: evaluations.current_page,
            total_pages: evaluations.total_pages,
            total_count: evaluations.total_count,
            per_page: evaluations.limit_value
          }
        }
      end

      def show
        evaluation = Evaluation.find(params[:id])

        effectiveness = evaluation.evaluate_effectiveness
        risk = evaluation.evaluate_risk
        team = evaluation.evaluate_team
        financing_feasibility = evaluation.evaluate_financing_feasibility(effectiveness[:aggregated_score],
                                                                          risk[:aggregated_membership],
                                                                          team[:defuzzification])

        render json: { evaluation: EvaluationSerializer.render_as_hash(evaluation),
                       result: { effectiveness:, risk:, team:, financing_feasibility: } }
      end

      def create
        evaluation = current_user.evaluations.build(evaluations_params)

        return unless evaluation.save!

        effectiveness = evaluation.evaluate_effectiveness
        risk = evaluation.evaluate_risk
        team = evaluation.evaluate_team
        financing_feasibility = evaluation.evaluate_financing_feasibility(effectiveness[:aggregated_score],
                                                                          risk[:aggregated_membership],
                                                                          team[:defuzzification])

        render json: {
          effectiveness:,
          risk:,
          team:,
          financing_feasibility:
        }

        # TODO: Add pdf report generation here in the future
      end

      private

      def evaluations_params
        params.require(:evaluation).permit(:team_competencies, :team_competencies_and_experience,
                                           :team_leaders_competencies, :team_professional_activity, :team_stability,
                                           :feasibility_linguistic,
                                           effectiveness_sum_scores_attributes: %i[value order],
                                           effectiveness_min_scores_attributes: %i[value order],
                                           effectiveness_max_scores_attributes: %i[value order],
                                           effectiveness_desired_scores_attributes: %i[value order],
                                           effectiveness_weight_scores_attributes: %i[value order],
                                           risk_financial_scores_attributes: %i[linguistic authenticity order],
                                           risk_investment_scores_attributes: %i[linguistic authenticity order],
                                           risk_operational_scores_attributes: %i[linguistic authenticity order],
                                           risk_innovation_activity_scores_attributes: %i[linguistic authenticity
                                                                                          order],
                                           team_stability_scores_attributes: %i[linguistic confidence weight order],
                                           team_professional_competency_scores_attributes: %i[linguistic confidence
                                                                                              weight order],
                                           team_professional_activity_scores_attributes: %i[linguistic confidence
                                                                                            weight order])
      end
    end
  end
end
