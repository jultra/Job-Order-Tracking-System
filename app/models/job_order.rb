class JobOrder < ApplicationRecord
  belongs_to :user
  has_many :logs, foreign_key: :job_order_id
  validates :where, :date_needed, :time_needed, :information, :job_type, presence: true
end
