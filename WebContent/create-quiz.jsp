<!-- @author Jujhaar Singh -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.*" %>
<% Class<?>[] klasses = AbstractQuestion.getQuestionSubclasses(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="javascripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="javascripts/create-quiz.js.jsp"></script>
	<link rel="stylesheet" type="text/css" href="stylesheets/application.css" />
	<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
	<link rel="stylesheet" type="text/css" href="stylesheets/quiz.css" />
<title>Create Quiz</title>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="control-bar.jsp" />
		
		<form action="create-quiz" method="post">
			<p class="box" id="title">
				<input type="text" name="title" placeholder="Title" /><br />
				<textarea name="description" placeholder="Description"></textarea>
				<br />
				<a href="load-xml-quiz.jsp">Have a Quiz XML file? Upload it here.</a>
			</p>
		
			<input type="hidden" name="number-of-questions" value="0" />
			<div class="panel">
				<div id="questions">
					<h2 class="box">Questions</h2>
					<ol></ol>
					<div class="last-float">&nbsp;</div>
				
					<select id="question-type">
						<option selected="selected">New Question...</option>
						<% for (Class<?> klass : klasses) { %>
							<option value="<%= klass.getSimpleName() %>">
								<%= klass.getMethod("userFriendlyName").invoke(klass) %>
							</option>
						<% } %>
					</select>
				</div>
				
				<div id="quiz-flags">
					<h2 class="box">Quiz Options</h2>
					<p class="box">
						<label for="random-order">Question Order:</label>
						<select name="random-order">
							<option value="false">Sequential</option>
							<option value="true">Random</option>
						</select>
						<br />
						<br />
						
						<label for="multiple-pages">Pages Displayed:</label>
						<select name="multiple-pages">
							<option value="false">One Page for Quiz</option>
							<option value="true">One Page per Question</option>
						</select>
						<br />
					    
						<label for="immediate-correction">Give the user instant feedback after answering?</label>
						<select name="immediate-correction" disabled="disabled">
							<option value="false">No</option>
							<option value="true">Yes</option>
						</select>
						<br />
						<small>Note: This option is only available when displaying one page per question.</small>
						
						<label for="seconds-per-question">Seconds Alloted Per Question:</label>
						<input type="number" name="seconds-per-question" value="0" min="0" step="1" disabled="disabled" /><br />
						<small>Note: Put 0 for unlimited time per question. This option is only available when displaying one page per question.</small>
						<br />
						<br />
						
						<label for="practice-mode">Allow Practice Mode?</label>
						<select name="practice-mode">
							<option value="true">Yes</option>
							<option value="false">No</option>
						</select>
					</p>
					<div class="last-float">&nbsp;</div>
				</div>
			</div>
			<img id="amp-img" src="images/lone_amp.png" alt="amp logo" />
			<p id="submit-p">
					<input class="box" id="submit-button" type="submit" value="Create Quiz!" />
				</p>
		</form>
	</div>

</body>
</html>