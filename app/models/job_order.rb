class JobOrder < ApplicationRecord
  belongs_to :user
  validates :control_no, :where, :date_needed, :time_needed,  :information, :job_type, presence: true

end
