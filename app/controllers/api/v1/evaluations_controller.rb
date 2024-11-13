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

        render json: evaluation.evaluate

        # TODO: Add pdf report generation here in the future
        # TODO: Add calculation of two other methods of evaluation in the future
      end

      private

      def evaluations_params
        params.require(:evaluation).permit(effectiveness_sum_scores_attributes: %i[value order],
                                           effectiveness_min_scores_attributes: %i[value order],
                                           effectiveness_max_scores_attributes: %i[value order],
                                           effectiveness_desired_scores_attributes: %i[value order],
                                           effectiveness_weight_scores_attributes: %i[value order])
      end
    end
  end
end
