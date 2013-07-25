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
<% String category = request.getParameter("category"); %>

<title>View Quizzes in <%=category%> Category</title>
</head>
<body>

	<div class="wrapper">
		<jsp:include page="control-bar.jsp" />


		<div class="header">
			<h1>VIEW QUIZZES IN <%=category %> CATEGORY</h1>
		</div>

		<div class="list-by-category">View by category&nbsp;&nbsp;&nbsp;</div>
			<div class="list-by-category">
				<form action="ListByCategory" method="post">
				<select name="categoryName">
					<%
						ArrayList<String> categories = Quiz.getAllCategories();
						if (categories.size() > 0) {
							for (String cat : categories) {
					%>
					<option value="<%=cat%>"><%=cat%></option>
					<%
						}
						}
					%>
				</select> <input type="submit" value="View" />
			</form>
		</div>
	
		<div class="backpanel">

			<div class="data">
				<table>
					<tr>
						<th>NAME</th>
						<th>AUTHOR</th>
						<th>DATE</th>
					</tr>

					<%
						ArrayList<Quiz> quizzes = Quiz.getQuizzesOfACategory(category);
						java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
								"yyyy-MM-dd HH:mm");

						for (Quiz q : quizzes) {
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