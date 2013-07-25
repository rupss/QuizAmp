
$(function() {
	var hasExecutedClickEvent = false;
	$("#user-form input[type=submit]").click(function() {
		var username = $(this).attr("data-username");
		// disable all other input fields to prevent submitting them
		$("#user-form tr:not([data-username=" + username + "]) input").attr("disabled", "disabled");
		
		hasExecutedClickEvent = true;
		$("#user-form").submit(); // now submit the form
	});
	
	// only allow user form submission through the click event
	$("#user-form").submit(function(event) {
		if (!hasExecutedClickEvent) {
			event.preventDefault();
			return false;
		}
	});
});

$(function() {
	var hasExecutedClickEvent = false;
	$("#quiz-form input[type=submit]").click(function() {
		var quizId = $(this).attr("data-quizId");
		// disable all other input fields to prevent submitting them
		$("#quiz-form tr:not([data-quizId=" + quizId + "]) input").attr("disabled", "disabled");
		
		hasExecutedClickEvent = true;
		$("#quiz-form").submit(); // now submit the form
	});
	
	// only allow quiz form submission through the click event
	$("#quiz-form").submit(function(event) {
		if (!hasExecutedClickEvent) {
			event.preventDefault();
			return false;
		}
	});
});