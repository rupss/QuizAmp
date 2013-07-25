<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="Users.*, java.util.*, quiz.*"%>

<%-- NOTE: to use this page, please include controlBar.css and put this in the body or wrapper div --%>

<% 
User currentUser = (User) request.getSession().getAttribute("currentUser");
String username = (currentUser == null) ? "Guest" : currentUser.getUsername();
%>

<div id="control-bar">
	<a href="index.jsp"><img id = "dashlogo" src= <%= "images/dashlogo.jpg" %> alt="dashlogo"></a>
	
	<div class = "controlbar">
		
		
			<div class = "graybutton">
				<a class ="buttontext" href = "UserProfile.jsp?username=<%= username %>" > <%= username %></a>
			</div>
	
			<% 
				String highScoreString = "";	
				if (currentUser != null) {
					double highScoreDouble = currentUser.getHighestScore();
					if (highScoreDouble >= 0) highScoreString = ((Double) highScoreDouble).toString() + "%";
					else highScoreString = "No Scores Yet";
				} else {
					highScoreString="No Scores Yet";
				}
			%>
			<div class = "graybutton">
				<p class = "buttontext" id="scoretext"> Your Top Score = <%= highScoreString %> </p>
			</div>
	
			<div class="graybutton">
				<% if (currentUser==null) { %>
					<p class ="buttontext"> Welcome! </p>
				<% } else { %>
				<a class ="buttontext" href = "create-quiz.jsp"> Create Quiz </a>
				<% } %>
			</div>
			<div class = "graybutton">
				<a class ="buttontext" href = "selectQuiz.jsp"> Select Quiz </a>
			</div>
			
			<div class="graybutton">
				<%if (username=="Guest") { %>
					<a class="buttontext" href="index.jsp">Login</a>
				<%} else { %>
					<a class="buttontext" href="logout">Logout</a>
				<%} %>
			</div>
	
	</div>
</div>
