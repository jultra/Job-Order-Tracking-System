class AddProgressToJobOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :job_orders, :progress, :string
  end
end
