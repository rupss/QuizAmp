
var questionTimerInterval; // global interval variable
/*
 * Show only question with the given questionNumber. Also updates the navigation
 * buttons (prev and next) and submit button as appropriate.
 */
function showQuestion(questionNumber) {
	// hide all that may be hidden
	$("#questions li").hide();
	$("input[type=submit]").hide();
	$("#exitButton").show();
	$(".nav-button").hide();
	
	// now show items which should be shown
	$("#questions li[data-number=" + questionNumber + "]").show();
	if (questionNumber > 1) { // show previous button
		$("#nav-buttons").off("click", "#prev-button");
		$("#nav-buttons").on("click", "#prev-button", function() {
			showQuestion(questionNumber - 1);
		});
		$("#prev-button").show();
	}
	
	var numberOfQuestions = $("#questions li").size();
	if (questionNumber < numberOfQuestions) { // show next button
		$("#nav-buttons").off("click", "#next-button");
		$("#nav-buttons").on("click", "#next-button", function() {
			showQuestion(questionNumber + 1);
		});
		$("#next-button").show();
	}
	else {
		$("input[type=submit]").show(); // show submit button
	}
	
	// start timer if exists
	setTimer();
}

// function to call if there is an AJAX error
function ajaxError(arg1, arg2, arg3) {
	$("#ajax-status").html("There was an error connecting with the server. Please try again.");
}

/*
 * Submits the form to the server to see if the currently displayed question is correct
 * and shows the response.
 */
function giveCorrection(questionNumber) {
	// First figure out which question order number this is.
	// It may not be questionNumber since the quiz may be in a random order.
	// Highly dependent on the format of the input names.
	var inputName = $("#questions li:visible input[name]").attr('name');
	var prefixLength = inputName.match(/quiz-[0-9]+-question-/)[0].length;
	var orderNumber = inputName.substr(prefixLength);
	$("input[name=order-number]").val(orderNumber);
	
	// submit ajax request to see if answer is correct
	$.ajax({
		url: "immediate-correction",
		type: "post",
		data: $("form").serialize(), // send form data
		dataType: "json",
		success: function(data) {
			clearInterval(questionTimerInterval); // stop timer
			var isCorrect = data.correct;
			var answer = data.answer;
			answer = answer.replace(/(\\r)?\\n/g, '<br />'); // hack to make multi-answer look nice
			if (isCorrect == "true" || isCorrect == "false") {
				// show if correct
				if (isCorrect == "true") $("#ajax-status").html(answer + "<br /> is Correct!");
				else $("#ajax-status").html(answer + "<br /> is Wrong!");
				var numberOfQuestions = $("#questions li").size();
				// set up next button navigation
				if (questionNumber < numberOfQuestions) {
					$("#next-button").html("Next Question");
					$("#nav-buttons").off("click", "#next-button");
					$("#nav-buttons").on("click", "#next-button", function() {
						showQuestionWithFeedback(questionNumber + 1);
					});
					$("#next-button").show();
				} else { // show submit button
					$("#next-button").hide();
					$("input[type=submit]").show();
				}
				$("#questions li input:visible").hide(); // prevent them from editing answer
			} else {
				ajaxError(data);
			}
		},
		error: ajaxError
	});
}

/*
 * Show the question number and set up the navigation button
 * to enable instant feedback.
 */
function showQuestionWithFeedback(questionNumber) {
	$("#questions li").hide();
	$("input[type=submit]").hide();
	$("#ajax-status").html("&nbsp;");
	
	$("#questions li[data-number=" + questionNumber + "]").show();
	$("#next-button").html("Submit Question");
	$("#nav-buttons").off("click", "#next-button");
	$("#nav-buttons").on("click", "#next-button", function() {
		giveCorrection(questionNumber);
	});
	$("#next-button").show();
	// start timer if exists
	setTimer();
}

// set up timer to countdown and force next, if the timer exists
function setTimer() {
	clearInterval(questionTimerInterval);
	var timer = $("#timer-number");
	if (!timer.is("*")) return; // return if timer does not exist
	var initSeconds = parseInt(timer.attr("data-start"), 10);
	var seconds = initSeconds;
	timer.text(seconds + ".0");
	var decimal = 0; // number after the decimal, 0-9
	questionTimerInterval = window.setInterval(function() {
		if (decimal > 0) decimal--;
		else {
			seconds--;
			decimal = 9;
		}
		timer.text(seconds + "." + decimal);
		if (seconds == 0 && decimal == 0) { // force user to next question
			clearInterval(questionTimerInterval);
			var nextButton = $("#next-button");
			if (nextButton.is(":visible")) {
				nextButton.click();
			} else {
				$("input[type=submit]").click(); // submit form
			}
		}
	}, 100);
}


