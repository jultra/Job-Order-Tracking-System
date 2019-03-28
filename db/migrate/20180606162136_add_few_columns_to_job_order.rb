class AddFewColumnsToJobOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :job_orders, :inspection_date, :date
    add_column :job_orders, :inspection_remarks, :text
    add_column :job_orders, :assignment_remarks, :text
    add_column :job_orders, :assignment_date, :date
    add_column :job_orders, :money_budget, :float
    add_column :job_orders, :money_spent, :float
    add_column :job_orders, :date_completed, :date
  end
end
