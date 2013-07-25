<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="stylesheets/application.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/dashboard.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/searchbar.css" />
<script type="text/javascript" src="javascripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="javascripts/dashboard.js"></script>
<script type="text/javascript" src="javascripts/friends.js"></script>
<script type="text/javascript" src="javascripts/announcements.js"></script>


<%@ page import="Users.*, java.util.*, quiz.*"%>
<title>Welcome to QuizAmp, <%
	User user = (User) request.getSession().getAttribute("currentUser");
	String username = user.getUsername();
	out.println(username); //GET USERNAME FROM SERVLET
%>!
</title>
</head>
<body>
	<%
		ArrayList<String> friends = user.getFriends();

			//out.println(friends.size());
	%>
	<div class="wrapper">
		<jsp:include page="control-bar.jsp" />

		<div class="search">

			<form action="displayUserResult" method="post">
				<span id="text"> Search for User: </span> <input type="text"
					name="username" class="search-input" /> <span class="buttonspan">
					<input type="submit" value="Search" id="searchbutton" />
				</span>

			</form>

		</div>

		<%
			if (user.isAdmin()) {
		%>
		<div id="admin">
			<p>
				<a href="admin.jsp">Admin Page</a>
			</p>
		</div>
		<%
			}
		%>

		<!--  ROW 1 -->

		<div class="row">

			<div class="panel" id="historyQuizzesTaken">
				<div class="header">
					<%
						String upperName = username.toUpperCase();
									out.println(upperName);
									ArrayList<QuizTaken> qts = user.getQuizHistory();
					%>
					HISTORY - QUIZZES TAKEN
				</div>
				&nbsp;
				<%
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
								"yyyy-MM-dd HH:mm");
						 java.text.SimpleDateFormat sdf_full = new java.text.SimpleDateFormat(
									"yyyy-MM-dd HH:mm:ss");
						int size; 
						if (qts.size() > 0) {
				%>
				<table>
					<tr>
						<th>Date</th>
						<th>Quiz Name</th>
						<th>Score</th>
						<th>Duration</th>

					</tr>
					<%
						size = Math.min(qts.size(), 3);
									for (int i = 0; i < size; i++) {
										QuizTaken n = qts.get(i);
										Quiz q = Quiz.readDB(n.getQuizId());
										out.println("<tr>");
										out.println("<td>"
												+ sdf.format(new Date(n.getTimeTaken().getTime()))
												+ "</td>");
										String url = "QuizSummary.jsp?id=" + q.getQuizId();
										String shortenedQuizName = Quiz.shortenQuizName(q.getName(), 25);
										//out.println("<td class=\"quizName\"><a href=\"" + url + "\" id=\"restrict\">" + q.getName()
												//+ "</a></td>");
										out.println("<td class=\"quizName\"><a href=\"" + url + "\" id=\"restrict\">" + shortenedQuizName
												+ "</a></td>");
										out.println("<td>" + n.getScore() + "%</td>");
										out.println("<td>" + Quiz.roundToTwoDecimalPlaces(n.getDuration()/1000.0) + "s</td>");
										out.println("</tr>");
									}
					%>
				</table>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getQuizHistory">
						View All</a>
				</div>
				<%
					}
						else {
							out.println("<br>No quizzes taken yet.");
						}
				%>
			</div>

			<div class="panel" id="historyQuizzesCreated">
				<div class="header">
					<%
						upperName = username.toUpperCase();
									out.println(upperName);
									ArrayList<Quiz> created = user.getQuizCreated();
					%>
					HISTORY - QUIZZES CREATED
				</div>
				&nbsp;
				<%
					if (created.size() > 0) {
				%>
				<table>
					<tr>
						<th>Date</th>
						<th>Quiz Name</th>
					</tr>
					<%
						size = Math.min(created.size(), 3);
									for (int i = 0; i < size; i++) {
										Quiz q = created.get(i);
										out.println("<tr>");
										out.println("<td>" + sdf.format(q.getTimeCreated()) + "</td>");
										String url = "QuizSummary.jsp?id=" + q.getQuizId();
										String shortenedQuizName = Quiz.shortenQuizName(q.getName(), 36);
										out.println("<td class=\"quizName\"><a href=\"" + url + "\">" + shortenedQuizName
												+ "</a></td>");
										out.println("</tr>");
									}
					%>
				</table>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getQuizCreated">
						View All</a>
				</div>
				<%
					} else {
							out.println("<br>You haven't created any quizzes yet.");
						}
				%>
			</div>

			<div class="panel" id="achievements">
				<div class="header">ACHIEVEMENTS</div>
				<%
					ArrayList<String> achievements = user.getAchievements();
				%>
				&nbsp;
				<%
					if (achievements.size() > 0) {
				%>
				<table>
					<%
						size = Math.min(achievements.size(), 3);
								for (int i = 0; i < size; i++) {
									String s = achievements.get(i);
									String imgstring = "\"images/" + s + ".jpg\"";
									String mouseover = "\"displayTip(event, \'" + s + "\', true);\"";
									String mouseout =  "\"displayTip(event, \'" + s + "\', false);\"";
									String id = "";
									if (s.equals("Amateur Author"))
										id = "SmallAImage";
									else
										id = "AImage";
									out.println("<tr>");
									out.println("<td>" + s + "</td>");
									String classname = "\"hasTip\"";
									out.println("<td> <span class =" 
											+ classname + 
											"onmouseover=" 
											+ mouseover + 
											"onmouseout=" 
											+ mouseout + 
											"> <img src=" + imgstring + "id=" + id + "> </span>");
									out.println("</tr>");
								}
					%>
				</table>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getAchievements">
						View All</a>
				</div>
				<%
					} else {
							out.println("<br>No achievements earned yet.");
						}
				%>
			</div>
			<div class="last-float">&nbsp;</div>
		</div>

		<div class="row">

			<div class="randomPanel" id="random">
				<div class="header">RANDOM QUESTION!</div>
				&nbsp;
				<%
					AbstractQuestion randomQ = user.getRandomQuestion();
						if (randomQ == null) {
							out.println("<br>No questions in database yet.");
						}
						else {
							String html = randomQ.toHTML();
							out.println(html); 
							out.println("&nbsp;");
							String link = "QuizSummary.jsp?id=" + randomQ.getQuizId();
							Quiz quiz = Quiz.readDB(randomQ.getQuizId());
							out.println("<div>From Quiz: <a href=\"" + link + "\">" + quiz.getName() + "</a></div>");
						}
				%>
			</div>

			<div class="QPanel" id="QDiv">
				<img src="images/Q logo.jpg" id="QImage">
			</div>

			<div class="panel" id="popularQuizzes">
				<div class="header">POPULAR QUIZZES</div>
				&nbsp;
				<%
					Map<Quiz, Integer> quizCounts = user.getPopularQuizzes(); //contains 3
								ArrayList<Integer> counts = new ArrayList<Integer>();
								for (Quiz q : quizCounts.keySet()) {
									counts.add(quizCounts.get(q));

								}
								Collections.sort(counts);
								Collections.reverse(counts);
								if (counts.size() > 0) {
				%>
				<table>
					<tr>
						<th>Name</th>
						<th>Creator</th>
					</tr>


					<%
						for (Integer c : counts) {
										Quiz quiz = null;
										for (Quiz q : quizCounts.keySet()) {
											if (quizCounts.get(q).equals(c)) {
												quiz = q;
												quizCounts.remove(q);
												break;
											}
										}
										out.println("<tr>");
										String url = "QuizSummary.jsp?id=" + quiz.getQuizId();
										String shortenedQuizName = Quiz.shortenQuizName(quiz.getName(), 36);
										out.println("<td class=\"quizName\"><a href=\"" + url + "\">" + shortenedQuizName
												+ "</a></td>");
										out.println("<td><a href=UserProfile.jsp?username=" + quiz.getUsername()
												+ ">" + quiz.getUsername() + "</a></td>");
										out.println("</tr>");

									}
					%>
				</table>
				<%
					}
								else {
								out.println("<br>No popular quizzes.");
								}
				%>
			</div>
			<div class="last-float">&nbsp;</div>
		</div>

		<div class="row">

			<div class="panel" id="announcements">
				<div class="header">ANNOUNCEMENTS</div>
				&nbsp;
				<%
					ArrayList<Announcement> announcements = user.getAnnouncements();
						if (announcements.size() > 0) {
				%>
				<table style="border-spacing: 5px;">
					<tr>
						<th>Time</th>
						<th>From</th>
						<th>Title</th>
						<th>Content</th>
						<th>&nbsp;</th>
					</tr>
					<%
						size = Math.min(announcements.size(), 3);
						for (int i = 0; i < size; i++) {
							Announcement a = announcements.get(i);
							out.println("<tr data-announcement-id=\"" + a.getId() + "\">");
							String currentTime = sdf.format(a.getDate());
							out.println("<td>" + currentTime + "</td>");
							out.println("<td><a href=UserProfile.jsp?username=" + a.getAuthor()
									+ ">" + a.getAuthor() + "</a></td>");
							out.println("<td>" + a.getTitle() + "</td>");
							String shortenedText = Quiz.shortenQuizName(a.getText(), 120);
							out.println("<td><a href=\"IndividualAnnouncement.jsp?time=" + sdf_full.format(a.getDate()) + "&from=" + a.getAuthor() + "&title=" + a.getTitle() + "&content=" + a.getText() + "\">" + shortenedText + "</td>");
							out.println("<td><img src=\"images/x.jpeg\" class=\"check_or_x\" alt=\"x\" title=\"Dismiss Announcement\" onclick=\"dismissAnnouncement(" + a.getId() + ")\" /></td>");
							out.println("</tr>");
						}

					%>
				</table>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getAnnouncements">
						View All</a>
				</div>
				<%
					} else {
							out.println("<br>No announcements.");
						}
				%>
			</div>
			<div class="last-float">&nbsp;</div>
		</div>

		<div class="row">
			<div class="panel" id="recentlyTakenQuizzes">
				<div class="header">SYSTEM-WIDE RECENTLY TAKEN QUIZZES</div>
				&nbsp;
				<%
					ArrayList<Quiz> quizzes = user.getMostRecentlyTakenQuizzes(); //contains 3 
							if (quizzes.size() > 0) {
				%>
				<table>
					<tr>
						<th>Time</th>
						<th>Name</th>
						<th>Creator</th>
						<th>Quiz-Taker</th>
					</tr>
					<%
						for (Quiz q : quizzes) {
										out.println("<tr>");
										out.println("<td>" + sdf.format(q.getTimeCreated()) + "</td>");
										String url = "QuizSummary.jsp?id=" + q.getQuizId();
										String shortenedQuizName = Quiz.shortenQuizName(q.getName(), 22);
										out.println("<td class=\"quizName\"><a href=\"" + url + "\">" + shortenedQuizName
												+ "</a></td>");
										out.println("<td><a href=UserProfile.jsp?username=" + q.getUsername()
												+ ">" + q.getUsername() + "</a></td>");
										
										//NOTE - q.getDescription() actually gets the quiz-taker's username (IN THIS SITUATION, from user.getMostRecentlyTakenQuizzes() ONLY)
										out.println("<td><a href=UserProfile.jsp?username=" + q.getDescription() + ">" + q.getDescription() + "</a></td>");
										out.println("</tr>");
									}
					%>
				</table>
				<%
					} else {
							out.println("<br>You haven't taken any quizzes yet.");
						}
				%>
				<br> <br>
			</div>

			<div class="panel" id="recentlyCreatedQuizzes">
				<div class="header">SYSTEM-WIDE RECENTLY CREATED QUIZZES</div>
				&nbsp;
				<%
					quizzes = User.getTopThreeRecentlyCreatedQuizzes(); //contains 3 or fewer
						if (quizzes.size() > 0) {
				%>
				<table>
					<tr>
						<th>Time</th>
						<th>Name</th>
						<th>Creator</th>
					</tr>
					<%
						for (Quiz q : quizzes) {
										out.println("<tr>");
										out.println("<td>" + sdf.format(q.getTimeCreated()) + "</td>");
										String url = "QuizSummary.jsp?id=" + q.getQuizId();
										String shortenedQuizName = Quiz.shortenQuizName(q.getName(), 30);
										out.println("<td class=\"quizName\"><a href=\"" + url + "\">" + shortenedQuizName
												+ "</a></td>");
										out.println("<td><a href=UserProfile.jsp?username=" + q.getUsername()
												+ ">" + q.getUsername() + "</a></td>");
										out.println("</tr>");
									}
					%>
				</table>
				<%
					} else {
							out.println("<br>No recently created quizzes.");
						}
				%>

			</div>

			<div class="panel" id="challenges">
				<div class="header">CHALLENGES</div>
				<%
					ArrayList<Challenge> challenges = user.getChallenges();
						if (challenges.size() > 0) {
				%>
				<table>
					<tr>
						<th>Date</th>
						<th>From</th>
						<th>Quiz Name</th>
						<th>Challenger's High Score</th>
					</tr>
					<%
						size = Math.min(challenges.size(), 3);
									for (int i = 0; i < size; i++) {
										Challenge n = challenges.get(i);
										Quiz q = Quiz.readDB(n.getQuizID());
										out.println("<tr>");
										out.println("<td>" + sdf.format(n.getDate()) + "</td>");
										out.println("<td><a href=UserProfile.jsp?username=" + n.getFromUsername()
												+ ">" + n.getFromUsername() + "</a></td>");
										String url = "QuizSummary.jsp?id=" + q.getQuizId();
										String shortenedQuizName = Quiz.shortenQuizName(q.getName(), 20);
										out.println("<td class=\"quizName\"><a href=\"" + url + "\">" + shortenedQuizName
												+ "</a></td>");
										double topScore = q.getUserTopScore(n.getFromUsername());
										if (topScore != -1.0) {
											out.println("<td>" + topScore + "%</td>");
										}
										else {
											out.println("<td>None</td>");
										}
										out.println("</tr>");
									}
					%>

				</table>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getChallenges">
						View All</a>
				</div>
				<%
					} else {
							out.println("<br>No challenges.");
						}
				%>

			</div>
			<div class="last-float">&nbsp;</div>
		</div>

		<div class="row">
			<div class="panel" id="friendActivity">
				<div class="header">FRIEND RECENT ACTIVITY</div>
				&nbsp;
				<%
					ArrayList<Activity> factivities = user.getFriendActivity();
						if (factivities.size() > 0) {
				%>
				<div class="data">
					<ul>
						<%
							size = Math.min(factivities.size(), 3);
											for (int i = 0; i < size; i += size) {
												Activity a = factivities.get(i);
												String name = a.getUsername();
												String quizName = a.getQuizName();
												int id = a.getQuizID();
												double score = a.getScore();
												Date date = a.getDate();
												boolean create = a.getCreated();
												String verb = "";
												if (create) {
													verb = " created ";
												} else {
													verb = " took ";
												}
												String scoreString = "";
												if (score != -1) {
													scoreString = " and scored ";
												}

												sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

												String formattedTime = sdf.format(date);
												String formattedDate = " on " + formattedTime;
												String url = "QuizSummary.jsp?id=" + id;
												String nameurl = "<a href=UserProfile.jsp?username=" + name
														+ ">" + name + "</a>";
												out.println("<li>" + nameurl + verb + "<a href=\"" + url
														+ "\">" + quizName + "</a>" + formattedDate
														+ "</li></td>");

											}
						%>
						<%
							HashMap<String, ArrayList<String>> friendAchievements = user
													.getFriendAchievements();
											Set<String> friendSet = friendAchievements.keySet();
											for (String f : friendSet) {
												ArrayList<String> a = friendAchievements.get(f);
												size = Math.min(a.size(), 1);
												for (int i = 0; i < size; i++) {
													String nameurl = "<a href=UserProfile.jsp?username=" + f
															+ ">" + f + "</a>";
													String ach = a.get(i);
													String isA = " has achieved ";
						%>
						<li><%=nameurl%> <%=isA%> <%=ach%></li>

						<%
							}
											}
						%>
					</ul>
				</div>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getFriendActivity">
						View All</a>
				</div>
				<%
					}
						else {
							out.println("<br>No friend activity.");
						}
				%>
			</div>



			<div class="panel" id="friendRequests">
				<div class="header">FRIEND REQUESTS</div>
				&nbsp;
				<%
					ArrayList<FriendRequest> frs = user.getFriendRequests();
						if (frs.size() > 0) {
				%>
				<table>
					<tr>
						<th>Date</th>
						<th>From</th>
					</tr>
					<%
						size = Math.min(frs.size(), 3);
									for (int i = 0; i < size; i++) {
										FriendRequest n = frs.get(i);
										out.println("<tr data-username=\"" + n.getFromUsername() + "\">");
										out.println("<td>" + sdf.format(n.getDate()) + "</td>");
										out.println("<td><a href=UserProfile.jsp?username=" + n.getFromUsername()
												+ ">" + n.getFromUsername() + "</a></td>");
										out.println("<td><img src=\"images/check.jpeg\" class=\"check_or_x\" id=\"check\"" + 
												"onclick=\"acceptFriendRequest('" + n.getFromUsername() + "')\" /></td>");
										out.println("<td><img src=\"images/x.jpeg\" class=\"check_or_x\" id=\"x\""
												+ "onclick=\"rejectFriendRequest('" + n.getFromUsername() + "')\" /></td>");			
										out.println("</tr>");
									}
					%>
				</table>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getFriendRequests">
						View All</a>
				</div>
				<%
					} else {
							out.println("<br>No friend requests.");
						}
				%>
			</div>

			<div class="panel" id="friends">
				<div class="header">FRIENDS</div>
				&nbsp;
				<%
					if (friends.size() > 0) {
				%>
				<table>
					<%
						for (String friend : friends) {
										out.println("<tr><td><a href=UserProfile.jsp?username=" + friend
												+ ">" + friend + "</a></td></tr>");
									}
					%>
				</table>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getFriends">
						View All</a>
				</div>
				<%
					} else {
							out.println("<br>No friends.");
						}
				%>
			</div>
			<div class="last-float">&nbsp;</div>
		</div>

		<div class="row">
			<div class="panel" id="notes">
				<div class="header">NOTES</div>
				&nbsp;
				<%
					ArrayList<Note> notes = user.getNotes();
						if (notes.size() > 0) {
				%>
				<table style="border-spacing: 5px;">
					<tr>
						<th>Date</th>
						<th>From</th>
						<th>Text</th>
					</tr>
					<%
						size = Math.min(notes.size(), 3);
									for (int i = 0; i < size; i++) {
										Note n = notes.get(i);
										String rowString = "<tr";
										if (n.isRead()) {
											rowString += " class=\"read\"";
										}
										rowString += ">";
										out.println(rowString);
										out.println("<td>" + sdf.format(n.getDate()) + "</td>");
										String usernameATag = "<a href=UserProfile.jsp?username=" + n.getFromUsername();
										if (n.isRead()) {
											usernameATag += " class=\"read\"";
										}
										usernameATag += ">";
										out.println("<td>" + usernameATag + n.getFromUsername() + "</a></td>");
										String link = "IndividualMessage.jsp?from=" + n.getFromUsername() + "&time=" + sdf_full.format(n.getDate());
										String shortenedText = Quiz.shortenQuizName(n.getText(), 145);
										String textATag = "<a href=\"" + link + "\"";
										if (n.isRead()) {
											textATag += " class=\"read\"";
										}
										textATag += ">";
										out.println("<td>" + textATag + shortenedText + "</a></td>");
										out.println("</tr>");
									}
					%>

				</table>
				&nbsp;
				<div class="seeall">
					<a class="seealllink"
						href="displayAll.jsp?username=<%=username%>&action=getNotes">
						View All</a>
				</div>
				<%
					} else {
							out.println("<br>No notes.");
						}
				%>
			</div>
		</div>
		<div class="last-float">&nbsp;</div>
	</div>


	<div class="tip" id="Amateur Author">
		<div class="tipTitle">Amateur Author</div>
		<div class="tipText">Created one quiz.</div>
	</div>

	<div class="tip" id="Prolific Author">
		<div class="tipTitle">Prolific Author</div>
		<div class="tipText">Created five quizzes.</div>
	</div>

	<div class="tip" id="Prodigious Author">
		<div class="tipTitle">Prodigious Author</div>
		<div class="tipText">Created ten quizzes.</div>
	</div>


<div class="tip" id="Quiz Machine">
<div class="tipTitle">Quiz Machine</div>
<div class="tipText">Took five quizzes.</div>
</div>

	<div class="tip" id="Quiz Machine">
		<div class="tipTitle">Quiz Machine</div>
		<div class="tipText">Created five quizzes.</div>
	</div>


	<div class="tip" id="I am the greatest">
		<div class="tipTitle">I am the greatest</div>
		<div class="tipText">Achieved a high score.</div>
	</div>

	<div class="tip" id="Practice Makes Perfect">
		<div class="tipTitle">Practice Makes Perfect</div>
		<div class="tipText">Did practice mode.</div>
	</div>

	<script>

function displayTip(event,tipId,show) {
    var tipElem = document.getElementById(tipId);
	if (!show) {
	    tipElem.style.display = "none";
		return;
	}
	var scroll = document.body.scrollTop;
	tipElem.style.top = (event.clientY + scroll + 5) + "px";
	tipElem.style.left = (event.clientX + 5) + "px";
	tipElem.style.display = "inline";
}

</script>

</body>
</html>