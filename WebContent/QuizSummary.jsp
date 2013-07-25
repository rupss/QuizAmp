<!-- @author Jujhaar Singh -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.*"%>
<%@ page import="database.*"%>
<%@ page import="Users.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<%
	String clearPMode = request.getParameter("exitPM");
	if (clearPMode != null)
			request.getSession().setAttribute("questionMap", null);

	User currentUser = (User) request.getSession().getAttribute("currentUser");
	boolean loggedIn = true;
	if (currentUser==null) loggedIn = false;
	int id = Integer.parseInt(request.getParameter("id"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="stylesheets/QuizSummary.css" />
<link rel="stylesheet" type="text/css"
	href="stylesheets/application.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />

<%
	Quiz quiz = Quiz.readDB(id);
%>
<title><%=quiz.getName()%></title>
</head>
<body>
	<div class="wrapper">

		<jsp:include page="control-bar.jsp" />

		<div id="quiz-name">
			<span><%=quiz.getName()%></span>
		</div>


		<div id="tags_and_creator">
			<div id="tags-list">
				<b>Tags:&nbsp;</b>
				<%
					ArrayList<String> tags = quiz.getTags();
					if (tags.size() > 0) {
						String tagsString = "";
						for (String tag : tags) {
							String tagURL = "<a href=" + "\"TaggedQuizSearch.jsp?tag=" + tag + "\" class=\"tag-link\">" + tag + "</a>";
							tagsString += tagURL + ", ";
						}
						tagsString = tagsString.substring(0, tagsString.length() - 2)
								+ "&nbsp;&nbsp;";
						out.println(tagsString);
					} else {
						out.println("None Yet.&nbsp;&nbsp;");
					}
				%>
			</div>

			<div id="quiz-creator">
				<div>
					by <a href="UserProfile.jsp?username=<%=quiz.getUsername()%>"><%=quiz.getUsername()%></a>
				</div>
			</div>

			<div id="add-tag">
				<form action="AddTagToQuiz" method="post">
					Add Tag <input type="hidden" name="quizID" value="<%=id%>" /> <input
						type="text" name="tagName" /> <input type="submit" value="Submit" />
				</form>
			</div>

		</div>

		<div id="quiz-description">
			<p id="quiz-description-text"><%=quiz.getDescription()%></p>
			<p id="quiz-description-text">
				Created on:
				<%=quiz.getTimeCreated()%></p>
			<%
				if (quiz.canSeeXML(currentUser)) {
			%>
			<p id="quiz-description-text">
				<a href="quiz-xml.jsp?id=<%=id%>">View XML</a>
			</p>
			<%
				}
			%>
		</div>
		<div id="rating_and_category">

			<div id="category">
				<b>Category:&nbsp;</b>
				<% 	String category = quiz.getCategory();
					if (!category.equals("Uncategorized")) { %>
					<a href="QuizzesByCategory.jsp?category=<%=category %>" class="tag-link"><%=category%></a>&nbsp;&nbsp;
				<% } else {
					out.println(category + "&nbsp;&nbsp;");
				 }%>
			</div>
			
			<div id="quiz-rating">
				<span id="quiz-rating-text">Rating: <%=quiz.getQuizRating()%>
				</span>
			</div>
			<% if (quiz.canSeeXML(currentUser)) { %>
			<div id="set-category">
				<form action="SetQuizCategory" method="post">
					Set Category <input type="hidden" name="quizID" value="<%=id%>" /> <input
						type="text" name="categoryName" /> <input type="submit" value="Submit" />
				</form>
			</div>
			<%} %>
			
		</div>



		<div id="row">
			<div class="history-box" id="leftbox">
				<span class="hist-text">User History:</span><br />
				<%
					if(loggedIn)
					{
						QuizTaken[] qts = quiz.getUserHistory((String) ((User) request
							.getSession().getAttribute("currentUser")).getUsername());
						if (qts != null) {
							for (int i = 0; i < qts.length; i++) {
				%>
				<span class="history-item"> <%="You got : " + qts[i].getScore() + " on: "
								+ qts[i].getTimeTaken()%>
				</span> <br />
				<%
						}
				%>
				<%
						}
					}
				%>
			</div>

			<div id=midbox>
				<div class="history-box" id="midhighbox">
					<span class="hist-text">Recent History:</span><br />
					<%
							QuizTaken[] qtTime = quiz.getTopHistoryWithTime();
							if (qtTime != null) {
								for (int j = 0; j < qtTime.length; j++) {
					%>

					<span class="history-item"> <a
						href="UserProfile.jsp?username=<%=qtTime[j].getUsername()%>"><%=qtTime[j].getUsername()%></a>
						<%=" got :" + qtTime[j].getScore() + " on: "
								+ qtTime[j].getTimeTaken()%>
					</span> <br />
					<%
								}
					%>
					<%
							}
					%>
				</div>

				<div class="history-box" id="midlowbox">
					<span class="hist-text">Highest Performers Ever:</span><br />
					<%
							QuizTaken[] qtHigh = quiz.getTopHistory();
							if (qtHigh != null) {
								int size = Math.min(qtHigh.length, 3);
								for (int j = 0; j < size; j++) {
					%>
					<span class="history-item"> <a
						href="UserProfile.jsp?username=<%=qtHigh[j].getUsername()%>"><%=qtHigh[j].getUsername()%></a>
						<%=" got :" + qtHigh[j].getScore() + " on: "
								+ qtHigh[j].getTimeTaken()%>
					</span> <br />
					<%
								}
							}
					%>
				</div>
			</div>

			<div class="history-box" id="rightbox">
				<span class="hist-text">All History:</span><br />
				<%
					QuizTaken[] qt = quiz.getAllHistory();
					if (qt != null) {
						for (int j = 0; j < qt.length; j++) {
				%>
				<span class="history-item"> <a
					href="UserProfile.jsp?username=<%=qt[j].getUsername()%>"><%=qt[j].getUsername()%></a>
					<%=" got :" + qt[j].getScore() + " on: "
							+ qt[j].getTimeTaken()%>
				</span> <br />
				<%
					}
					}
				%>
			</div>
		</div>


		<div id="stats-box">

			<span id="statistics-header">STATISTICS BREAKDOWN</span><br />
			<div id="inner-stats">
				Average Score:
				<%=quiz.averageScore()%>
				<br /> Average Duration:
				<%=quiz.averageDuration()%>
				<br /> Number of Times Taken:
				<%=quiz.numberTimesTaken()%>
				<br /> Max Score:
				<%=quiz.getTopScore()%>
				<br /> Min Score:
				<%=quiz.getBottomScore()%>
				<br />
			</div>
		</div>

		<form action="ViewQuiz.jsp" method="get">
			<div id="button">
				<%
					if (quiz.isPracticeMode()) {
				%>
				<div id="practiceMode">
					<input type="checkbox" name="practiceMode" id="check" /> Practice
					Mode?
				</div>
				<%
					}
				%>
				<input type="hidden" name="id"
					value="<%=request.getParameter("id")%>" /> <input type=submit
					id="submit-button" value="LET'S GO!" />
			</div>
		</form>
	</div>
</body>
</html>