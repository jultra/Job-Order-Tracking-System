class ChangeDivisionOfficeToBeIntegerAndForeignKeyInUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :division_office, :string

  	add_reference :users, :office, foreign_key: true
  end
end
