<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheets/display.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/centerimage.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<%@ page
			import="Users.User, java.util.*, quiz.*, java.net.URL"%>
<%
Double score = (Double) request.getAttribute("score");
Long duration =  (Long) request.getAttribute("duration");
User currentUser = (User) request.getSession().getAttribute("currentUser");
Quiz quiz = (Quiz) request.getAttribute("quiz");
int quizId = quiz.getQuizId();
String title;
if (score < 50.0) title = "Ouch!";
else if (score < 75) title = "Okay...";
else if (score < 100) title = "Nice job!";
else title = "Is that you, Patrick?";
%>

		<title><%= title %></title>
	</head>

	<div class = "bodyclass">


		<jsp:include page="control-bar.jsp" />


		<div class = "header"> 
			<h1> <%= title %></h1>
		</div>
		<body>
			<div class = "backpanel">
				<h1>You just took the <%= request.getAttribute("quizName") %> Quiz! </h1>
				<h3>Your score: <%= score %>%</h3>
				<h3>Your time: <%= duration / 1000 %>.<%= (duration % 1000) / 10 %> seconds</h3>
		
				<form action="QuizRatingServlet" method="post">
					<input type="hidden" name="timeTaken" value="<%=request.getAttribute("timeTaken")%>"/>
					<input type="hidden" name="quizID" value="<%=request.getAttribute("quizID")%>"/>
					<input type="hidden" name="username" value="<%=request.getAttribute("username")%>"/>
					<input type="text" name="rating">
					Rate (0-5) <input type="submit" value="Rate this quiz"/>
				</form>
			</div>

	
	<div class = "backpanel" id = "subsequentbackpanel">
		<div class = "minibackpanel">
			<h3> Your Most Recent Scores: </h3>
				<table>
					<tr>
						<th>Score</th>
						<th>Date</th>	
					</tr>
					
				<% 
				   QuizTaken[] userHistory = quiz.getUserHistory(currentUser.getUsername());
				   if (userHistory.length == 0) {
					   out.println("<tr>");
					   out.println("<td> none </td>");
					   out.println("<td> none </td>");
					   out.println("</tr>");
				   }
				   int size = Math.min(userHistory.length, 6);
				   for (int i = 1; i < size; i++) {
					  QuizTaken qt = userHistory[i];
					  double scoreHist = qt.getScore();
					  out.println("<tr>");
					  out.println("<td>" + scoreHist + "%</td>");
					  out.println("<td>" + qt.getTimeTaken() + "</td>");
					  out.println("</tr>");
				   }
				   %>
		
				</table>
		</div>
		
		<div class = "minibackpanel" id = "subsequentminibackpanel">
			<h3> Top Five Scorers: </h3>
			<table>
					<tr>
						<th>Score</th>
						<th>Name</th>
						<th>Date</th>	
					</tr>
				<% 
				   QuizTaken[] topHistory = quiz.getTopHistory();
				 if (topHistory.length == 0) {
					   out.println("<tr>");
					   out.println("<td> none </td>");
					   out.println("<td> none </td>");
					   out.println("</tr>");
				   }
				   size = Math.min(topHistory.length, 5);
				   for (int i = 0; i < size; i++) {
					  QuizTaken qt = topHistory[i];
					  double scoreHist = qt.getScore();
					  out.println("<tr>");
					  out.println("<td>" + scoreHist + "%</td>");
					  out.println("<td>" + qt.getUsername() + "</td>");
					  out.println("<td>" + qt.getTimeTaken() + "</td>");
					  out.println("</tr>");
				   }
				   %>
			</table>
			</div>
			
			<div class = "minibackpanel">
				<h3> Friend Recent History </h3>
				<form id = friendForm action="resultsWithFriend" method="post">
					<select name = "friendSelect">
						<%
						ArrayList<String> friends = currentUser.getFriends();
						String name = "";
						for (String f : friends) {
							name = f;
							out.println("<option value=\"" + name + "\">" + name + "</option>");
						}
						%>
					</select> 
			
					<input type = "hidden" name = "quizId" value = "<%=quizId%>" />
					<input type = "hidden" name = "friend" value= "<%=name%>" />
					<input type = "hidden" name = "score" value= "<%=score%>" />
					<input type = "hidden" name = "duration" value = "<%=duration%>" />
					<span class = "buttonspan"> 
					<p></p>
						<input type= "submit"  value="Compare" id="submitbutton" /> </span> 
				</form>
			
			</div>
			
			<div class = "enddiv">
			&nbsp;
			</div>
	</div>
	
	
	
	<div class = "image">
	
		<% String url = "dashboard.jsp?id=" + currentUser.getUsername(); %>
		<a href="dashboard.jsp?id=" + <%=url %> > <img id = "image" width = 400px; src= <%= "images/dashlogo.jpg"%> alt="LOGO"> </a>
	</div>
	
</body>

	</html>