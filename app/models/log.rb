class Log < ApplicationRecord
	belongs_to :job_order, polymorphic: true
	belongs_to :actor, class_name: "User"
end
