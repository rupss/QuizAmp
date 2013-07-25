

function ajaxError() {
	alert("There was a problem connecting to the server. Please try again later.");
}

function sendFriendAJAX(username, makeFriends, successFn) {
	$.ajax({
		url: "friend-request",
		type: "post",
		data: {
			username: username,
			makeFriends: makeFriends
		},
		dataType: "json",
		success: function(data) {
			if (data.success) {
				successFn(data);
			} else {
				// forward to given URL
				if (data.href) location.href = data.href;
				else ajaxError();
			}
		},
		error: ajaxError
	});
}

