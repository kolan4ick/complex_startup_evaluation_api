class RemoveFeasibilityThresholdFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :feasibility_threshold, :float
  end
end
