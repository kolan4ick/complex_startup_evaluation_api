class UserSerializer < Blueprinter::Base
  identifier :id

  fields :email, :name, :feasibility_threshold, :adjustment_delta, :created_at, :updated_at

  view :extended do
    association :evaluations, blueprint: EvaluationSerializer
    association :feasibility_levels, blueprint: FeasibilityLevelSerializer do |user|
      user.feasibility_levels.order(:order)
    end
  end
end
