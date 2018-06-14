class JobOrder < ApplicationRecord
  belongs_to :user
  validates :where, :date_needed, :time_needed, :information, :job_type, presence: true

end
