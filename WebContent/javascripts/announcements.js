
function dismissAnnouncement(announcementId) {
	var ajaxError = function() {
		alert("There was a problem connecting to the server. Please try again later.");
	};
	
	$.ajax({
		url: "dismiss-announcement",
		type: "post",
		data: {
			announcementId: announcementId
		},
		dataType: "json",
		success: function(data) {
			if (data.success) {
				$("[data-announcement-id=" + announcementId +"]").hide();
			} else {
				// forward to given URL
				if (data.href) location.href = data.href;
				else ajaxError();
			}
		},
		error: ajaxError
	});
}