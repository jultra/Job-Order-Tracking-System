class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.integer :job_order_id
      t.string :job_order_type
      t.integer :actor_id
      t.datetime :action_at
      t.string :action
      t.string :comment

      t.timestamps
    end
  end
end
