class UserSerializer < Blueprinter::Base
  identifier :id

  fields :email, :name, :feasibility_threshold, :created_at, :updated_at

  view :extended do
    association :evaluations, blueprint: EvaluationSerializer
    association :feasibility_levels, blueprint: FeasibilityLevelSerializer
  end
end
