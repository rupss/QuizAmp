<%@page import="java.util.*"%>
<%@page import="Users.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.*" %>
	<!-- Check if  user is logged in -->
	<%
	if (((User)request.getSession().getAttribute("currentUser"))==null) { %>
		<jsp:forward page="index.jsp" />
	<%}%>

<!-- Check if they submitted answers through practice mode -->
<%
HashMap<Integer, Integer> questionMap;
if (request.getSession().getAttribute("questionMap") == null) 
	questionMap = new HashMap<Integer, Integer>();
else
	questionMap = (HashMap<Integer, Integer>) request.getSession().getAttribute("questionMap");
%>

<% 
Date time = new Date();
int id = Integer.parseInt(request.getParameter("id"));
Quiz testquiz = Quiz.readDB(id);
AbstractQuestion[] aqs = testquiz.getQuestions();
boolean multiplePages = testquiz.isMultiplePages();
boolean immediateCorrection = testquiz.isImmediateCorrection();
String practiceMode = request.getParameter("practiceMode");
int secondsPerQuestion = testquiz.getSecondsPerQuestion();
boolean pMode = false;
if(practiceMode != null)
	if (practiceMode.equals("on")) pMode = true;
if (pMode) secondsPerQuestion = 0; // disable timer if in practice mode
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Quiz</title>
	<link rel="stylesheet" type="text/css" href="stylesheets/application.css" />
	<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
	<link rel="stylesheet" type="text/css" href="stylesheets/quiz.css" />
	<script type="text/javascript" src="javascripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="javascripts/ViewQuiz.js"></script>
	<script type="text/javascript">
	<% if (immediateCorrection) { %>
		$(function() {
			showQuestionWithFeedback(1);
		});
	<% } else if (multiplePages) { %>
		$(function() {
			showQuestion(1);
		});
	<% } %>
	</script>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="control-bar.jsp" />
		
		<div class="box" id="title">
		<h1><%=testquiz.getName() %> Quiz</h1>
		<h2>by <%=testquiz.getUsername() %></h2>
		<%if (pMode) {%>
			<form action="QuizSummary.jsp" method="get">		
			<h2>Practice Mode is ON
				<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
				<input type="hidden" name="exitPM" value="yes"/>
				<br/>
				<input id="exitButton" type="submit" value="Exit Practice Mode"/>
			</h2>
			<h3>Answer each question right three times to complete the practice mode!</h3>
			</form>
		<% } %>
		</div>
			<form action="GradeQuizServlet" method="post" class="view-quiz">
			<input type="hidden" name="quizId" value="<%= testquiz.getQuizId() %>" />
			<input type="hidden" name="duration" value="<%= time.getTime() %>" />
			<input type="hidden" name="practiceMode" value="<%= request.getParameter("practiceMode") %>" />
		<% if (immediateCorrection) { %>
			<input type="hidden" name="order-number" />
		<% } %>

		<div class="panel">
			<% if (secondsPerQuestion > 0) { %>
			<div class="box" id="timer">
				<h3>
					<span id="timer-number" data-start="<%= secondsPerQuestion %>">
						<%= secondsPerQuestion %>.0
					</span> seconds
				</h3>
			</div>
			<% } %>
			<div id="questions">
				<ol>
						<%
						boolean questionsLeft = false;
						for(int i=0; i<aqs.length; i++)
						{%>
							<% if (!questionMap.containsKey(aqs[i].getNumber())) questionMap.put(aqs[i].getNumber(), 0); %>
								<% if (multiplePages) { %>
									<li class="box multiple-pages" data-number="<%= i + 1 %>">
								<% } else { %>
									<li class="box">
								<% } %>
							<% if (questionMap.get(aqs[i].getNumber()) < 3) { %>
								Question <%=i+1%>: <%= aqs[i].toHTML() %>
								</li>
								<% questionsLeft = true; %>
							<%} else { %>
								<br/><br/><p align="center">You have mastered this Question!</p></li>
							<%} %>
						<%
						}
						if (questionsLeft)
							request.getSession().setAttribute("questionMap", questionMap);
						%>
				</ol>
				<div class="last-float">&nbsp;</div>
				<% if (immediateCorrection) { %>
					<p id="ajax-status">&nbsp;</p>
				<% } %>
			</div>
			<% if (multiplePages) { %>
				<div id="nav-buttons">
					<% if (!immediateCorrection && secondsPerQuestion == 0) { %>
					<a class="box nav-button" id="prev-button">Previous Question</a>
					<% } %>
					<a class="box nav-button" id="next-button">Next Question</a>
					<div class="last-float">&nbsp;</div>
				</div>
			<% } %>
		</div>
		<img id="amp-img" src="images/lone_amp.png" alt="amp logo" />
		<p id="submit-p">
		<% if (questionsLeft) { %>
			<input class="box" id="submit-button" type="submit" value="AMP ME!" />
		<% } else { %>
			<% String url = "QuizSummary.jsp?id="+id;%>
			<% request.getSession().setAttribute("questionMap", null);%>
			
			<jsp:forward page="<%=url %>" />
		<% } %>
		</p>
	</form>
	</div>
</body>
</html>