function acceptFriendRequest(username) {
	sendFriendAJAX(username, true, function(data) {
		$("#friendRequests tr[data-username=" + username + "]").hide();
//		$("#friendbutton").text("Friends");
//		$("#friendbutton").attr("onclick", ""); // disable click listener
	});
}

function rejectFriendRequest(username) {
	sendFriendAJAX(username, false, function(data) {
		$("#friendRequests tr[data-username=" + username + "]").hide();
//		$("#friendbutton").text("Add Friend");
//		$("#friendbutton").attr("onclick", "addFriend('" + user.getUsername() + "')"); // enable different click listener
	});
}
