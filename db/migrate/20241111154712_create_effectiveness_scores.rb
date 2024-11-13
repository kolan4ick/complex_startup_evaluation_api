class CreateEffectivenessScores < ActiveRecord::Migration[8.0]
  def change
    create_table :effectiveness_scores do |t|
      t.float :value
      t.integer :order
      t.references :evaluation, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
