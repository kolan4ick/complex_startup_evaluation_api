class EvaluationSerializer < Blueprinter::Base
  identifier :id

  fields :team_competencies, :team_competencies_and_experience, :team_leaders_competencies,
         :team_professional_activity, :team_stability, :feasibility_linguistic, :created_at, :updated_at

  association :user, blueprint: UserSerializer
  association :effectiveness_sum_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_min_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_max_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_desired_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_weight_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_desired_term_scores, blueprint: RiskScoreSerializer
  association :risk_financial_scores, blueprint: RiskScoreSerializer
  association :risk_innovation_activity_scores, blueprint: RiskScoreSerializer
  association :risk_investment_scores, blueprint: RiskScoreSerializer
  association :risk_operational_scores, blueprint: RiskScoreSerializer
  association :team_stability_scores, blueprint: TeamScoreSerializer
  association :team_professional_competency_scores, blueprint: TeamScoreSerializer
  association :team_professional_activity_scores, blueprint: TeamScoreSerializer
end
