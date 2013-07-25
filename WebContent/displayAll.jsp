<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%@ page
			import="Users.*, java.util.*, quiz.*, java.net.URL"%>
<link rel="stylesheet" type="text/css" href="stylesheets/application.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/display.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<script type="text/javascript" src="javascripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="javascripts/friends.js"></script>
<script type="text/javascript" src="javascripts/announcements.js"></script>
			
<title>Display All</title>





</head>
<body>

<div class = "bodyclass">

<jsp:include page="control-bar.jsp" />


	<div class = "header"> 
			<h1> VIEW ALL </h1>
	</div>

	<% String username = request.getParameter("username"); 
	   User user = new User(username);
	   // user.getUs
	   String action = request.getParameter("action");
	   java.text.SimpleDateFormat sdf = 
			new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	   java.text.SimpleDateFormat sdf_full = 
				new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	%>
	
	<div class = "backpanel" >
		<!-- FRIENDS -->
		<% if (action.equals("getFriends")) { %>
		<h3> FRIENDS </h3>
		<%
			ArrayList<String> friends = user.getFriends();
			if (friends.size() == 0) {
				out.println("No friends.");
			} else {
				for (int i = 0; i < friends.size(); i++) {
					String f = friends.get(i);
				%>
				<li> <a id="link" href="UserProfile.jsp?username=<%=f%>"> <%= f %> </a> </li>
			<% } 
			}
		}%>
		
		<!-- ACHIEVEMENTS -->
		<% if (action.equals("getAchievements")) { %>
		<h3> ACHIEVEMENTS </h3>
		<% 
			ArrayList<String> achievements = user.getAchievements();
		if (achievements.size() == 0) {
			out.println("No achievements.");
		} else {
			for (int i = 0; i < achievements.size(); i++) {
				String s = achievements.get(i);
				String mouseover = "\"displayTip(event, \'" + s + "\', true);\"";
				String mouseout =  "\"displayTip(event, \'" + s + "\', false);\"";
				String imgstring = "\"images/" + s + ".jpg\"";
				String id = "";
				if (s.equals("Amateur Author"))
					id = "SmallAImage";
				else
					id = "AImage";
					
			%>
			<li> <p> <%=s %> &nbsp; 
			<span 
			class = "hasTip" 
			onmouseover=<%=mouseover%> 
			onmouseout=<%=mouseout%> >
				 <img src = <%= imgstring %> id = <%=id%>>  </p> </span> </li>
			<% }
		}
		} %>
		
			
		<!-- PROFILE PAGE SPECIFIC : A USER'S HISTORY -->
		<% if (action.equals("getHistory")) { %>
		<h3> QUIZ TAKING HISTORY </h3>
		<%
			ArrayList<QuizTaken> quizTaken = user.getQuizHistory();
			int size = quizTaken.size();
			if (size == 0) {
				out.println("No quizzes taken.");
			} else {
				for (int i = 0; i < quizTaken.size(); i++) {
					QuizTaken qt = quizTaken.get(i);
					Quiz q = qt.getQuiz();
					int id = q.getQuizId();
				%>
				<li> <a id="link" href="QuizSummary.jsp?id=<%=id%>"> <%= q.getName() %> </a> </li>
				<%}
			}%>
			<h3> QUIZ CREATING HISTORY </h3>
			<% 
			ArrayList<Quiz> quizC = user.getQuizCreated();
			if (quizC.size() == 0) {
				out.println("No quizzes created.");
			} else {
				for (int i = 0; i < quizC.size(); i++) {
					Quiz q = quizC.get(i);
					int id = q.getQuizId();
				%>
				<li> <a id="link" href="QuizSummary.jsp?id=<%=id%>"> <%= q.getName() %> </a> </li>
				<% }
			}
		}%>
		
		<!-- USER ANNOUNCEMENTS -->
		<% if (action.equals("getAnnouncements")) {
			ArrayList<Announcement> announcements = user.getAnnouncements(); 
			sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
			if (announcements.size() == 0) {
				out.println("No announcements.");
			} else {
		%>
			<h3> ANNOUNCEMENTS </h3>
				<table cellpadding=6px>
					<tr>
						<th>Time</th>
						<th>From</th>
						<th>Title</th>
						<th>Content</th>
					</tr>
		<%		for (Announcement a : announcements) {
					out.println("<tr data-announcement-id=\"" + a.getId() + "\">");
					String currentTime = sdf.format(a.getDate());
					out.println("<td>" + currentTime + "</td>");
					out.println("<td><a href=UserProfile.jsp?username=" + a.getAuthor()
							+ ">" + a.getAuthor() + "</a></td>");		
					out.println("<td>" + a.getTitle() + "</td>");
					String shortenedText = Quiz.shortenQuizName(a.getText(), 100);
					out.println("<td><a href=\"IndividualAnnouncement.jsp?time=" + sdf_full.format(a.getDate()) + "&from=" + a.getAuthor() + "&title=" + a.getTitle() + "&content=" + a.getText() + "\">" + shortenedText + "</td>");
					out.println("<td><img src=\"images/x.jpeg\" class=\"check_or_x\" alt=\"x\" title=\"Dismiss Announcement\" onclick=\"dismissAnnouncement(" + a.getId() + ")\" /></td>");
					out.println("</tr>");
				}
			}
		}
		%>
		</table>
		
		
		
		<!-- FRIEND REQUESTS -->
		<% if(action.equals("getFriendRequests")) {
		ArrayList<FriendRequest> frs = user.getFriendRequests(); 
					int size = frs.size();
					if (size == 0) {
						out.println("No friend requests.");
					} else {%>
		<h3> FRIEND REQUESTS </h3>
				<table cellpadding=6px>
					<tr>
						<th>Date</th>
						<th>From</th>
					</tr>
				<%
						for (int i = 0; i < size; i++) {
							FriendRequest n = frs.get(i); 
							out.println("<tr>");
							out.println("<td>" + sdf.format(n.getDate()) + "</td>");
							out.println("<td><a href=UserProfile.jsp?username=" + n.getFromUsername()
									+ ">" + n.getFromUsername() + "</a></td>");
							out.println("</tr>");
						}
					}
		}
		%>
		</table>
		
		<!-- NOTES -->
		<% if(action.equals("getNotes")) {
		ArrayList<Note> notes = user.getNotes(); 
					int size = notes.size();
					if (size == 0) {
						out.println("No notes.");
					} else {%>
		<h3> NOTES </h3>
				<table cellpadding=6px>
					<tr>
						<th>DATE</th>
						<th>FROM</th>
						<th>TEXT</th>
					</tr>
				<%
						for (int i = 0; i < size; i++) {
							Note n = notes.get(i); 
							String rowString = "<tr";
							if (n.isRead()) {
								rowString += " class=\"read\"";
							}
							rowString += ">";
							out.println(rowString);
							out.println("<td>" + sdf.format(n.getDate()) + "</td>");
							out.println("<td><a href=UserProfile.jsp?username=" + n.getFromUsername()
									+ ">" + n.getFromUsername() + "</a></td>");
							String link = "IndividualMessage.jsp?from=" + n.getFromUsername() + "&time=" + sdf_full.format(n.getDate());
							String shortenedText = Quiz.shortenQuizName(n.getText(), 145);
							out.println("<td><a href=\"" + link + "\">" + shortenedText + "</a></td>");
							out.println("</tr>");
						}
					}
					
		}%>
		</table>
		
		<!-- CHALLENGES -->
		<% if (action.equals("getChallenges")) {
		ArrayList<Challenge> challenges = user.getChallenges();  
					int size = challenges.size(); 
					if (size == 0) {
						out.println("No challenges.");
					} else {%>
		<h3> CHALLENGES </h3>
					<table cellpadding=6px>
					<tr>
						<th>Date</th>
						<th>From</th>
						<th>Quiz Name</th>
						<th>Challenger's High Score</th>
					</tr>
				<%
						for (int i = 0; i < size; i++) {
							Challenge n = challenges.get(i); 
							Quiz q = Quiz.readDB(n.getQuizID()); 
							out.println("<tr>");
							out.println("<td>" + sdf.format(n.getDate()) + "</td>");
							out.println("<td><a href=UserProfile.jsp?username=" + n.getFromUsername()
									+ ">" + n.getFromUsername() + "</a></td>");
							String url = "QuizSummary.jsp?id=" + q.getQuizId();
							out.println("<td><a href=\"" + url + "\">" + q.getName()
									+ "</a></td>");
							out.println("<td>" + q.getUserTopScore(n.getFromUsername()) + "%</td>"); 
							out.println("</tr>");
						}
					}
		}
		%>
		</table>
		
		<!-- DASHBOARD: GET QUIZ HISTORY -->
		<% if(action.equals("getQuizHistory")) {
		ArrayList<QuizTaken> qts = user.getQuizHistory();  
					int size = qts.size(); 
					if (size == 0) {
						out.println("No quizzes taken.");
					} else {%>
		<% String upperName = username.toUpperCase();
		 %> <h3> <%=upperName%> HISTORY </h3>
				<table cellpadding=6px>
					<tr>
						<th>Date</th>
						<th>Quiz Name</th>
						<th>Score</th>
						<th>Duration</th>
					</tr>
				<%
						for (int i = 0; i < size; i++) {
							QuizTaken n = qts.get(i);
							Quiz q = Quiz.readDB(n.getQuizId());
							out.println("<tr>");
							out.println("<td>" + sdf.format(new Date(n.getTimeTaken().getTime())) + "</td>");
							String url = "QuizSummary.jsp?id=" + q.getQuizId();
							out.println("<td><a href=\"" + url + "\">" + q.getName()
									+ "</a></td>");
							out.println("<td>" + n.getScore() + "%</td>"); 
							out.println("<td>" + Quiz.roundToTwoDecimalPlaces(n.getDuration()/1000.0)+ " s</td>");
							out.println("</tr>");
						}
					}
		}
		%>
		</table>
		
		
		<!-- DASHBOARD getQuizCreated -->
		<% if (action.equals("getQuizCreated")) {
			ArrayList<Quiz> created = user.getQuizCreated();
				int size = created.size();
				if (size == 0) {
					out.println("No quizzes created.");
				} else {%>
		<% String upperName = username.toUpperCase();
		%> <h3> <%=upperName %> HISTORY </h3>
		<table cellpadding=6px>
			<tr>
				<th>Date</th>
				<th>Quiz Name</th>
			</tr>
			<%
					for (int i = 0; i < size; i++) {
						Quiz q = created.get(i);
						out.println("<tr>");
						out.println("<td>" + sdf.format(q.getTimeCreated()) + "</td>");
						String url = "QuizSummary.jsp?id=" + q.getQuizId();
						out.println("<td><a href=\"" + url + "\">" + q.getName()
								+ "</a></td>");
						out.println("</tr>");
					}
				}
		}
			%>
		</table>
		
		<!-- getFRIEND ACTIVITY -->
		<% if (action.equals("getFriendActivity")) {%>
				<ul>
					
				<%
						ArrayList<Activity> factivities = user.getFriendActivity();
						int size = factivities.size();
						if (size == 0) {
							out.println("No friend quiz activity."); %>
				<h3> FRIEND ACTIVITY </h3> <% 
						} else {
							for (int i = 0; i < size; i++) {
								Activity a = factivities.get(i);
								String name = a.getUsername();
								String nameLink = "<a href=\"UserProfile.jsp?username=" + name
									+ "\">" + name + "</a>";
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
									scoreString = " and scored " + score + "%";
								}
	
								sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								
								String formattedTime = sdf.format(date);
								String formattedDate = " on " + formattedTime;
								String url = "QuizSummary.jsp?id=" + id;
								out.println("<li><p>" + nameLink + verb + "<a href=\"" + url
											+ "\">" + quizName + "</a>" + scoreString   
											+ formattedDate + "</li></td>");
	
								}
						}
						%>
						<%
							HashMap<String, ArrayList<String>> friendAchievements = user
									.getFriendAchievements();
							Set<String> friendSet = friendAchievements.keySet();
							if (friendSet.isEmpty()) {
								out.println("No friend achievements.");
							} else {
								for (String f : friendSet) {
									ArrayList<String> a = friendAchievements.get(f);
									size = a.size();
									for (int i = 0; i < size; i++) {
										String friend =  "<a href= \"UserProfile.jsp?username=" + f
										+ "\">" + f + "</a>";
										String ach = a.get(i);
										String isA = " has achieved ";
							%>
							<li>
								<p>
									<%=friend%> <%=isA%> <%=ach%>
								</p>
							</li>
	
							<% 		} 
								}
							}%>
				
				</ul>
		<% } %>
					
		
		
	</div>
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

<div class="tip" id="I am the greatest">
<div class="tipTitle">I am the greatest</div>
<div class="tipText">Achieved a high score.</div>
</div>

<div class="tip" id="Practice Makes Perfect">
<div class="tipTitle">Practice Makes Perfect</div>
<div class="tipText">Did practice mode.</div>
</div>

<script><!-- 

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