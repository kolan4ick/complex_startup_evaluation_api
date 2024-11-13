class EvaluationSerializer < Blueprinter::Base
  identifier :id

  fields :user, :created_at, :updated_at

  association :effectiveness_sum_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_min_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_max_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_desired_scores, blueprint: EffectivenessScoreSerializer
  association :effectiveness_weight_scores, blueprint: EffectivenessScoreSerializer
end
