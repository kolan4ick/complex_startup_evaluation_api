class EffectivenessScoreSerializer < Blueprinter::Base
  identifier :id

  fields :value, :order, :evaluation
end
