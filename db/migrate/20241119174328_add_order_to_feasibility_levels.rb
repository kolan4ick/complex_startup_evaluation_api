class AddOrderToFeasibilityLevels < ActiveRecord::Migration[8.0]
  def change
    add_column :feasibility_levels, :order, :integer, default: 1
  end
end
