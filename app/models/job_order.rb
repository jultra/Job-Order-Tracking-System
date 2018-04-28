class JobOrder < ApplicationRecord
	validates :control_no, :where, :date_needed, :time_needed, :information, :requester, :adviser, :fund_source, :job_type, presence: true

end
