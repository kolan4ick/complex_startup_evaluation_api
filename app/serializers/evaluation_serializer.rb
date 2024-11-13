class EvaluationSerializer < Blueprinter::Base
  identifier :id

  fields :created_at, :updated_at

  association :user, blueprint: UserSerializer
  association :effectiveness_sum_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_min_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_max_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_desired_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_weight_scores, blueprint: EffectivenessScoreSerializer
  association :risk_financial_scores, blueprint: RiskScoreSerializer
  association :risk_innovation_activity_scores, blueprint: RiskScoreSerializer
  association :risk_investment_scores, blueprint: RiskScoreSerializer
  association :risk_operational_scores, blueprint: RiskScoreSerializer
end
