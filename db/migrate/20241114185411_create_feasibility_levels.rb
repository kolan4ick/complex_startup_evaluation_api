class CreateFeasibilityLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :feasibility_levels do |t|
      t.string :title
      t.float :value
      t.references :user, null: false, foreign_key: true
      t.integer :linguistic, default: 1

      t.timestamps
    end
  end
end
