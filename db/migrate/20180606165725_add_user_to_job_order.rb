class AddUserToJobOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :job_orders, :user, foreign_key: true
  end
end
