class RemoveSignatureFromJobOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_orders, :signature, :string
  end
end
