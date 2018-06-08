class AddForeignKeyToOffice < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :head_id, :integer
    add_foreign_key :offices, :users, column: :head_id, primary_key: "id"
  end
end
