class SetDefApproveFalse < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :active, from: true, to: false
    change_column_default :users, :approved, from: true, to: false
    change_column_default :users, :confirmed, from: true, to: false
  end
end
