class AddAdditionalFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    change_table :users, bulk: true do |t|
      t.float :feasibility_threshold
      t.float :adjustment_delta
    end
  end
end
