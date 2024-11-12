class EvaluationSerializer < Blueprinter::Base
  identifier :id

  field :user

  association :sum_scores, blueprint: EffectivenessScoreSerializer
  association :min_scores, blueprint: EffectivenessScoreSerializer
  association :max_scores, blueprint: EffectivenessScoreSerializer
  association :desired_scores, blueprint: EffectivenessScoreSerializer
  association :weight_scores, blueprint: EffectivenessScoreSerializer
end
