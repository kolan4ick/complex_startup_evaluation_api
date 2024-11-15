class CreateRiskScores < ActiveRecord::Migration[8.0]
  def change
    create_table :risk_scores do |t|
      t.integer :linguistic, default: 1
      t.float :authenticity
      t.string :type
      t.references :evaluation, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
