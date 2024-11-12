class UserSerializer < Blueprinter::Base
  identifier :id

  fields :email, :name, :created_at, :updated_at

  association :evaluations, blueprint: EvaluationSerializer
end
