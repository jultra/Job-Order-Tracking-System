class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :position
      t.string :fname
      t.string :mname
      t.string :lname

      t.timestamps
    end
  end
end
