class RiskScoreSerializer < Blueprinter::Base
  identifier :id

  fields :linguistic, :authenticity, :order, :evaluation, :created_at, :updated_at
end
