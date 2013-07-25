<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="stylesheets/application.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/chooseQuiz.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/searchbar.css" />

<%@ page import="Users.User, java.util.*, quiz.*, java.net.URL"%>

<title>View All Quizzes</title>
</head>
<body>

	<div class="wrapper">
		<jsp:include page="control-bar.jsp" />

		<div class="search">

			<form action="SearchQuizzesByTag" method="post">
				<span id="text" style="color: #616161;"> Search By Tag: </span> <input
					type="text" name="tagName" class="search-input" /> <span
					class="buttonspan"> <input type="submit" value="Search"
					id="searchbutton" />
				</span>

			</form>

		</div>

		<div class="header">
			<h1>CHOOSE A QUIZ</h1>
		</div>

	<%
		ArrayList<String> categories = Quiz.getAllCategories(); 
		if (categories.size() > 0) {
	%>

		<div>
			<div class="list-by-category">View by category&nbsp;&nbsp;&nbsp;</div>
			<div class="list-by-category">
				<form action="ListByCategory" method="post">
					<select name="categoryName">
						<%
							
						
								for (String cat : categories) {
						%>
						<option value="<%=cat%>"><%=cat%></option>
						<%
							}
							
						%>
					</select> <input type="submit" value="View" />
				</form>
			</div>
		</div>
		<% } %>

		<div class="backpanel">

			<div class="data">
				<table>
					<tr>
						<th>NAME</th>
						<th>AUTHOR</th>
						<th>DATE</th>
					</tr>

					<%
						java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
								"yyyy-MM-dd HH:mm");

						ArrayList<Quiz> qzs = Quiz.viewAllQuizzes();
						for (Quiz q : qzs) {
							out.println("<tr>");
							String url = "QuizSummary.jsp?id=" + q.getQuizId();
							out.println("<td><a href=\"" + url + "\">" + q.getName()
									+ "</a></td>");
							url = "UserProfile.jsp?username=" + q.getUsername();
							out.println("<td><a href=\"" + url + "\">" + q.getUsername()
									+ "</a></td>");
							out.println("<td>"
									+ sdf.format(new Date(q.getTimeCreated().getTime()))
									+ "</td>");
							out.println("</tr>");
						}
					%>

				</table>
			</div>
		</div>

	</div>


</body>
</html>