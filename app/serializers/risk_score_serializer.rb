class RiskScoreSerializer < Blueprinter::Base
  identifier :id

  fields :linguistic, :authenticity, :order, :created_at, :updated_at

  view :extended do
    association :evaluation, blueprint: EvaluationSerializer
  end
end
