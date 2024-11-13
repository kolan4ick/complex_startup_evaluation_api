class TeamScoreSerializer < Blueprinter::Base
  identifier :id

  fields :confidence, :linguistic, :order, :weight, :created_at, :updated_at

  view :extended do
    association :evaluation, blueprint: EvaluationSerializer
  end
end
