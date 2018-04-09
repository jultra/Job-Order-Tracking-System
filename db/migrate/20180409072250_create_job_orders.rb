class CreateJobOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :job_orders do |t|
      t.string :control_no
      t.string :job_type
      t.string :code
      t.text :information
      t.string :where
      t.string :requester
      t.string :adviser
      t.string :fund_source
      t.string :signature
      t.text :acknowledgment
      t.string :job_office
      t.string :inspected_by
      t.text :remarks
      t.string :available_materials
      t.string :assigned_to
      t.date :date_filed
      t.date :date_needed
      t.date :date_approved
      t.date :delivery_date
      t.time :time_needed
      t.date :date_started

      t.timestamps
    end
  end
end
