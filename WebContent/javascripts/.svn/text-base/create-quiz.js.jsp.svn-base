<%@ page language="java" contentType="text/javascript; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.*" %>
<% Class<?>[] klasses = AbstractQuestion.getQuestionSubclasses(); %>

// TODO: remove delete button from first answer
/*
 * Renumbers all questions and answers so that they are sequential, and so that
 * answers are properly associated with their question. This function should
 * be called every time the number of questions or answers is changed.
 */
function renumber() {
	var questionNumber = 0;
	// renumber input names
	$("#questions li").each(function() {
		questionNumber++;
		$(this).find(".question input").each(function() {
			var name = $(this).attr("name");
			var rootName = name.match(/[^0-9\-]+/)[0];
			$(this).attr("name", rootName + "-" + questionNumber);
		});
		var answerNumber = 0;
		$(this).find(".answer input").each(function() {
			answerNumber++;
			var name = $(this).attr("name");
			var rootName = name.match(/[^0-9\-]+/)[0];
			$(this).attr("name", rootName + "-" + questionNumber + "-" + answerNumber);
		});
	});
	$("input[name=number-of-questions]").val(questionNumber);
	
	// remove 'remove-buttons' from answers if only answer
	$("#questions li").each(function() {
		var numAnswers = $(this).find(".answer").size();
		var removeButtons = $(this).find(".answer .remove-button");
		if (numAnswers <= 1) removeButtons.css("display", "none");
		else removeButtons.css("display", "inline");
	});
}

/*
 * Adds a question with one answer to the form.
 */
function addQuestion(questionHTML, answerHTML) {
	var question = $("<div class=\"question\">" + questionHTML + "</div>");
	var li = $("<li class=\"box\"></li>");
	var removeButton = $("<a class=\"button remove-button\">x</a>");
	removeButton.click(function() {
		li.remove();
		renumber();
	});
	question.append(removeButton);
	li.append(question);
	addAnswer(li, answerHTML);
	$("#questions ol").append(li);
	renumber();
}

/*
 * Adds an answer to a question. The parent should be the parent of both
 * the question and the answer. 
 */
function addAnswer(parent, answerHTML) {
	var answer = $("<div class=\"answer\">" + answerHTML + "</div>");
	var addButton = $("<a class=\"button add-button\">+</a>");
	var removeButton = $("<a class=\"button remove-button\">x</a>");
	removeButton.click(function() {
		answer.remove(); // TODO: don't remove last answer
		renumber();
	});
	addButton.click(function(event) {
		addAnswer(parent, answerHTML);
	});
	answer.append(addButton);
	answer.append(removeButton);
	parent.append(answer);
	renumber();
}

/*
 * Set up a change event listener to add questions when the question type
 * is selected.
 */
$(function() {
	$("#question-type").change(function() {
		var klass = $("#question-type").val();
		<% for (Class<?> klass : klasses) { %>
			if (klass == "<%= klass.getSimpleName() %>") addQuestion('<%= klass.getMethod("newQuestionHTML").invoke(klass) %>',
					'<%= klass.getMethod("newAnswerHTML").invoke(klass) %>');
		<% } %>
		$("#question-type").val("");
	});
});

/* 
 * Disable/enable immediate correction and seconds/question so that it can only be turned on when multiple
 * pages is turned on.
 */
$(function() {
	$("[name=multiple-pages]").change(function() {
		var multiplePages = $(this).val();
		if (multiplePages == "true") $("[name=immediate-correction], [name=seconds-per-question]").removeAttr("disabled");
		else {
			$("[name=immediate-correction]").val("false");
			$("[name=seconds-per-question]").val("0");
			$("[name=immediate-correction], [name=seconds-per-question]").attr("disabled", "disabled");
		}
	});
});