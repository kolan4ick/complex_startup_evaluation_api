class ChangeAdditionalFieldsInUsers < ActiveRecord::Migration[8.0]
  def up
    change_table :users, bulk: true do |t|
      t.change :feasibility_threshold, :float, default: 0.1, null: false
      t.change :adjustment_delta, :float, default: 0.1, null: false
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.change :feasibility_threshold, :float, default: nil, null: true
      t.change :adjustment_delta, :float, default: nil, null: true
    end
  end
end
