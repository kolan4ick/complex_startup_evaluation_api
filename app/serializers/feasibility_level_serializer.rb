class FeasibilityLevelSerializer < Blueprinter::Base
  identifier :id

  fields :linguistic, :title, :value, :created_at, :updated_at

  view :extended do
    association :user, blueprint: UserSerializer
  end
end
