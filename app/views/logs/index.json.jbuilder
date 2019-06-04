json.array! @logs do |log|
	# json.recipient notification.recipient
	json.job_order do #log.job_order
		json.inspected_by_id log.job_order.inspected_by_id
		json.office_id log.job_order.office_id
		json.assigned_to_id log.job_order.assigned_to_id
	end
	json.actor log.actor.username
	json.action log.action
	json.date_time log.date_time
	json.comment log.comment
	# json.url job_order_path(notification.notifiable.id, anchor: dom_id(notification.notifiable))
end