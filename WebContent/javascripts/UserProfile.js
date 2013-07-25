
function addFriend(username) {
	sendFriendAJAX(username, true, function(data) {
		$("#friendbutton").text("Friend Request Pending");
		$("#friendbutton").removeAttr("onclick"); // disable click listener
	});
}

function acceptFriendRequest(username) {
	sendFriendAJAX(username, true, function(data) {
		$("#friendbutton").text("Remove Friendship");
		$("#friendbutton").attr("onclick", "removeFriendship('" + username + "')"); // enable different click listener
	});
}

function rejectFriendRequest(username) {
	sendFriendAJAX(username, false, function(data) {
		$("#friendbutton").text("Add Friend");
		$("#friendbutton").attr("onclick", "addFriend('" + username + "')"); // enable different click listener
	});
}

function removeFriendship(username) {
	sendFriendAJAX(username, false, function(data) {
		$("#friendbutton").text("Add Friend");
		$("#friendbutton").attr("onclick", "addFriend('" + username + "')"); // enable different click listener
	});
}

