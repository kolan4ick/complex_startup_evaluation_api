class UserSerializer < Blueprinter::Base
  identifier :id

  fields :email, :name, :created_at, :updated_at

  view :extended do
    association :evaluations, blueprint: EvaluationSerializer
  end
end
