class RefineOfficeTable < ActiveRecord::Migration[5.1]
  def change
    add_index :offices, :name, unique: true
    add_index :offices, :acronym, unique: true
  end
end
