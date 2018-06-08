class MoreForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_orders, :requester, :string
    remove_column :job_orders, :adviser, :string
    remove_column :job_orders, :job_office, :string
    remove_column :job_orders, :inspected_by, :string
    remove_column :job_orders, :assigned_to, :string

    add_column :job_orders, :adviser_id, :integer
    add_column :job_orders, :office_id, :integer
    add_column :job_orders, :inspected_by_id, :integer
    add_column :job_orders, :assigned_to_id, :integer

    add_column :offices, :acronym, :string
  end
end
