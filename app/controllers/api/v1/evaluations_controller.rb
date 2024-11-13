module Api
  module V1
    class EvaluationsController < ApplicationController
      before_action :authenticate_user!

      def index
        evaluations = current_user.evaluations

        render json: EvaluationSerializer.render_as_hash(evaluations)
      end

      def show
        evaluation = Evaluation.find(params[:id])

        render json: EvaluationSerializer.render_as_hash(evaluation)
      end

      def create
        evaluation = current_user.evaluations.build(evaluations_params)

        return unless evaluation.save!

        render json: { effectiveness: evaluation.evaluate_effectiveness, risk: evaluation.evaluate_risk }

        # TODO: Add pdf report generation here in the future
        # TODO: Add calculation of the last method of evaluation in the future
      end

      private

      def evaluations_params
        params.require(:evaluation).permit(effectiveness_sum_scores_attributes: %i[value order],
                                           effectiveness_min_scores_attributes: %i[value order],
                                           effectiveness_max_scores_attributes: %i[value order],
                                           effectiveness_desired_scores_attributes: %i[value order],
                                           effectiveness_weight_scores_attributes: %i[value order],
                                           risk_financial_scores_attributes: %i[linguistic authenticity order],
                                           risk_investment_scores_attributes: %i[linguistic authenticity order],
                                           risk_operational_scores_attributes: %i[linguistic authenticity order],
                                           risk_innovation_activity_scores_attributes: %i[linguistic authenticity
                                                                                          order])
      end
    end
  end
end
