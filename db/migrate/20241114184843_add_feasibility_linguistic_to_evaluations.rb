class AddFeasibilityLinguisticToEvaluations < ActiveRecord::Migration[8.0]
  def change
    add_column :evaluations, :feasibility_linguistic, :integer, default: 1
  end
end
