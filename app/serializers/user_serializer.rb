class UserSerializer < Blueprinter::Base
  identifier :id

  fields :email, :name

  association :evaluations, blueprint: EvaluationSerializer
end
