class Notifications
	constructor: ->
		@notifications = $("[data-behavior='notifications']")
		@setup() if @notifications.length > 0

	setup: -> 
		$("[data-behavior='notifications-link']").on "click", @handleClick
		$.ajax(
			url: "/notifications.json"
			dataType: "JSON"
			method: "GET" 
			success: @handleSuccess
		)

	handleClick: (e) =>
		$.ajax(
			url: "/notifications/mark_as_read"
			dataType: "JSON"
			method: "POST" 
			success: -> 
				$("[data-behavior='unread-count']").text(0)
		)

	handleSuccess: (data) =>
		items = $.map data, (notification) ->
			if notification.action == "SUBMIT"
				"<a class='dropdown-item' href='#{notification.url}'>#{notification.actor} submitted a request for #{notification.notifiable.job_type}</a>"
			else if notification.action == "RESUBMIT"
				"<a class='dropdown-item' href='#{notification.url}'>#{notification.actor} resubmitted a request for #{notification.notifiable.job_type}</a>"
			else if notification.action == "APPROVE"
				"<a class='dropdown-item' href='#{notification.url}'>#{notification.actor} approved a request for #{notification.notifiable.job_type}</a>"
			else if notification.action == "REJECT"
				"<a class='dropdown-item' href='#{notification.url}'>#{notification.actor} rejected a request for #{notification.notifiable.job_type}</a>"
			else
				"<a class='dropdown-item' href='#{notification.url}'>#{notification.actor} #{notification.action} your request for #{notification.notifiable.job_type}</a>"

		$("[data-behavior='unread-count']").text(items.length)
		$("[data-behavior='notification-items']").html(items)

jQuery ->
	new Notifications