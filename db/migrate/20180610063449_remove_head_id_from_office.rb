class RemoveHeadIdFromOffice < ActiveRecord::Migration[5.1]
  def change
    remove_column :offices, :head_id, :integer
  end
end
