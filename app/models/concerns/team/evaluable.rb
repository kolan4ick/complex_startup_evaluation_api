# frozen_string_literal: true

module Team
  module Evaluable
    extend ActiveSupport::Concern

    included do
      has_many :team_stability_scores, class_name: 'TeamScores::Stability', dependent: :destroy
      has_many :team_professional_competency_scores, class_name: 'TeamScores::ProfessionalCompetency',
                                                     dependent: :destroy
      has_many :team_professional_activity_scores, class_name: 'TeamScores::ProfessionalActivity', dependent: :destroy

      accepts_nested_attributes_for :team_stability_scores, :team_professional_competency_scores,
                                    :team_professional_activity_scores
    end

    def evaluate_team; end
  end
end
