class RemoveRemarksCreatedAtAndUpdatedAtFromJobOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_orders, :remarks, :text
    remove_column :job_orders, :created_at, :datetime
    remove_column :job_orders, :updated_at, :datetime
  end
end
