class UserSerializer < Blueprinter::Base
  identifier :id

  fields :email, :name, :adjustment_delta, :created_at, :updated_at

  view :extended do
    association :feasibility_levels, blueprint: FeasibilityLevelSerializer do |user|
      user.feasibility_levels.order(:order)
    end
  end
end
