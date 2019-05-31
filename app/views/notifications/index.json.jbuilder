json.array! @notifications do |notification|
	# json.recipient notification.recipient
	json.actor notification.actor.username
	json.action notification.action
	json.notifiable notification.notifiable
	json.url job_order_path(notification.notifiable.id, anchor: dom_id(notification.notifiable))
end