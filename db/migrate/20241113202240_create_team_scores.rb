class CreateTeamScores < ActiveRecord::Migration[8.0]
  def change
    create_table :team_scores do |t|
      t.integer :linguistic, default: 1
      t.float :confidence
      t.float :weight
      t.integer :order
      t.references :evaluation, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
