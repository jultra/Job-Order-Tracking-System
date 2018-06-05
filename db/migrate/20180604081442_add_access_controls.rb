class AddAccessControls < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.integer :accessType
      t.string :Division_Department
    end
  end
end
