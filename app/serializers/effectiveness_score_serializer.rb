class EffectivenessScoreSerializer < Blueprinter::Base
  identifier :id

  fields :value, :order, :evaluation, :created_at, :updated_at
end
