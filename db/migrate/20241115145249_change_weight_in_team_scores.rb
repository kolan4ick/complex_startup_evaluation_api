class ChangeWeightInTeamScores < ActiveRecord::Migration[8.0]
  def up
    change_column :team_scores, :weight, :integer, default: 1, null: false
  end

  def down
    change_column :team_scores, :weight, :float, default: nil, null: true
  end
end
