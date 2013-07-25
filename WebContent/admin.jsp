<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="Users.*, quiz.*, java.util.*" %>
<%
	User currentUser = (User) request.getSession().getAttribute("currentUser");
	if (currentUser == null || !currentUser.isAdmin()) { %>
		<jsp:forward page="index.jsp" />
	<% }
	String message = request.getParameter("message");
	if (message == null) message = "";
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="javascripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="javascripts/admin.js"></script>
	<link rel="stylesheet" type="text/css" href="stylesheets/dashboard.css" />
	<link rel="stylesheet" type="text/css" href="stylesheets/admin.css" />
	<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
	<title>Admin Page</title>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="control-bar.jsp" />
		
		<div id="admin">
			<h3> ADMIN PAGE </h3> <%= message %>
		</div>
		
		<div class="row">
			<div class="panel admin-panel" id="admin-announcement">
				<div class="header admin-header">
					Create Announcement
				</div>
				
				<form action="create-announcement" method="post" id="announcement-form">
					<table>
						<tr>
							<td><label for="title">Title</label></td>
							<td><input type="text" name="title" /></td>
						</tr>
						<tr>
							<td>Message</td>
							<td><textarea name="text" cols="15" rows="5"></textarea></td>
						</tr>
						<tr>
							<td colspan="2"><input type="submit" value="Post Announcement" /></td>
						</tr>
					</table>
				</form>
			</div>

			<div class="panel admin-panel" id="admin-panel">
				<div class="header admin-header" id = "admin-quizzes">
					Quizzes
				</div>
				<form action="update-quiz" method="post" id="quiz-form">
				<table>
					<tr>
						<th>Quiz name</th>
						<th>Clear History</th>
						<th>Remove</th>
					</tr>
					<% for (Quiz quiz: Quiz.viewAllQuizzes()) {%>
						<tr data-quizId="<%= quiz.getQuizId()%>">
							<td><%= quiz.getName()%></td>
							<td><input type="checkbox" name="clearHistory" value="true"/></td>
							<td><input type="checkbox" name="removeQuiz" value="true" /></td>
							<td>
								<input type="hidden" name="quizId" value="<%= quiz.getQuizId() %>" />
								<input type="submit" value="Update" data-quizId="<%= quiz.getQuizId() %>" />
							</td>
					<%}%>
				</table>
				</form>
			</div>
			
			<div class = "panel admin-panel" id = "stats-panel">
				<div class="header admin-header" id = "admin-quizzes">
						Site Statistics
				</div>
				<table>
						<tr>
							<th>Number of Users</th>
							<th>Number of Quizzes Taken</th>
							<th>Number of Quizzes</th>
						</tr>
						
						<td> <%= User.getTotalNumberOfUsers() %> </td>
						<td> <%= User.getTotalQuizzesTaken() %> </td>
						<td> <%= Quiz.getTotalNumberOfQuizzes() %> </td>
				</table>
				<%  Map<String, Integer> topTakers = User.getTopThreeQuizTakers();
				ArrayList<QuizTaken> topScores = User.getTopThreeScores(); 
				ArrayList<String> topCreators = User.getProlificCreators();
				Set<String> topTakerNames = topTakers.keySet(); %>
				<div class="header admin-header" >
						Top Quiz Takers By Amount Taken
				</div>
			<% 
				for (String n : topTakerNames) {
					out.println("<p>" + n + " took " + topTakers.get(n) + " quizzes" + "</p>");
				}
			%>
				<div class="header admin-header" >
						Top Scorers ever
				</div>
			<% 
				for (int i = 0; i < topScores.size(); i++) {
					QuizTaken qt = topScores.get(i);
					out.println("<p>" + qt.getUsername() + " high score: " + qt.getScore() + "%" + "</p>");
				}
			%>
				<div class="header admin-header" >
						Top Creators Ever
				</div>
			<% 
				for (int i = 0; i < topCreators.size(); i++) {
					out.println("<p>" + topCreators.get(i) + "</p>");
				}
			%>
			</div>
			
			
		</div>
		
		<!-- END OF ROW 1 -->
		
		<div class="row">
			<div class="panel wide-panel">
				<div class="header admin-header">
					Users
				</div>
				<form action="update-user" method="post" id="user-form">
					<table>
						<tr>
							<th>Username</th>
							<th>Admin?</th>
							<th>Removed?</th>
						</tr>
						<% for (User user : User.getAllUsers()) { %>
							<tr data-username="<%= user.getUsername() %>">
								<td><%= user.getUsername() %></td>
								<td><input type="checkbox" name="isAdmin" value="true"
									<%=  (user.isAdmin()) ? "checked=\"checked\"" : "" %> /></td>
								<td><input type="checkbox" name="remove" value="true" /></td>
								<td>
									<input type="hidden" name="username" value="<%= user.getUsername() %>" />
									<input type="submit" value="Update" data-username="<%= user.getUsername() %>" />
								</td>
							</tr>
						<% } %>
						<tr><td ><span style="font-weight:bold">Deleted Users:</span></td></tr>
						<% for (User delUser : User.getDeletedUsers()) { %>
							<tr data-username="<%= delUser.getUsername() %>">
								<td><%= delUser.getUsername() %></td>
								<td></td>
								<td><input type="checkbox" name="remove" value="true" checked="checked" /></td>
								<td>
									<input type="hidden" name="isDelUser" value="true"/>
									<input type="hidden" name="username" value="<%= delUser.getUsername() %>" />
									<input type="submit" value="Update" data-username="<%= delUser.getUsername() %>" />
								</td>
							</tr>
						<% } %>
					</table>
				</form>
			</div>
		</div>
		
		<div class = "row" >
			<div class = "panel wide-panel">
			
			<% ArrayList<Announcement> allAncs = User.viewAllAnnouncements(); 
			 java.text.SimpleDateFormat sdf = 
			new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	%>
			<div class="header admin-header">
					All Announcements 
			</div>
				<table cellpadding=6px>
					<tr>
						<th>Time</th>
						<th>From</th>
						<th>Title</th>
						<th>Content</th>
					</tr>
				<%	if (allAncs.size() ==0) {
					out.println("<tr>");
					out.println("<td> None </td>");
					out.println("<tr>");
				} 
				
				
				for (Announcement a : allAncs) {
							out.println("<tr>");
							String currentTime = sdf.format(a.getDate());
							out.println("<td>" + currentTime + "</td>");
							out.println("<td><a href=UserProfile.jsp?username=" + a.getAuthor()
									+ ">" + a.getAuthor() + "</a></td>");		
							out.println("<td>" + a.getTitle() + "</td>");
							out.println("<td>" + a.getText() + "</td>");
							out.println("</tr>");
						}
				%>
			</table>
			
			

			
			
			</div>
			
			<div class = "row" >
			<div class = "panel wide-panel">
			
			<% ArrayList<Announcement> myAncs = currentUser.getAdminAnnouncements(); 
			 sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
			%>
			<div class="header admin-header">
					My Announcements 
				</div>
				<table cellpadding=6px>
					<tr>
						<th>Time</th>
						<th>From</th>
						<th>Title</th>
						<th>Content</th>
					</tr>
				<%	if (myAncs.size() ==0) {
						out.println("<tr>");
						out.println("<td> None </td>");
						out.println("<tr>");
					} 
				for (Announcement a : myAncs) {
							out.println("<tr>");
							String currentTime = sdf.format(a.getDate());
							out.println("<td>" + currentTime + "</td>");
							out.println("<td><a href=UserProfile.jsp?username=" + a.getAuthor()
									+ ">" + a.getAuthor() + "</a></td>");		
							out.println("<td>" + a.getTitle() + "</td>");
							out.println("<td>" + a.getText() + "</td>");
							out.println("</tr>");
						}
				%>
				</table>
			
			</div>
		
		
		
		</div><!--
	
	
Map<String, Integer> getTopThreeQuizTakers()
ArrayList<QuizTaken> getTopThreeScores()
ArrayList<String> getProlificCreators()
		
	--></div>

</body>
</html>