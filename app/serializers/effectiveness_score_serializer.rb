class EffectivenessScoreSerializer < Blueprinter::Base
  identifier :id

  fields :value, :order, :created_at, :updated_at

  view :extended do
    association :evaluation, blueprint: EvaluationSerializer
  end
end
