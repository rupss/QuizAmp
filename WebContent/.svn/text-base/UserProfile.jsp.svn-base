<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheets/application.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/profile.css" />
<script type="text/javascript" src="javascripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="javascripts/friends.js"></script>
<script type="text/javascript" src="javascripts/UserProfile.js"></script>

<%@ page
			import="Users.User, java.util.*, quiz.*, java.net.URL"%>
<!-- Eventually interact with request -->
<%  
	String name = request.getParameter("username");
	User user = new User(name);
	User currentUser = (User) request.getSession().getAttribute("currentUser");
	if (currentUser == null) { %>
		<jsp:forward page="index.jsp" />
	<% } %>
	
<title> <%= user.getUsername() %> </title>
</head>

<body>

<div class = "wrapper" >
	<jsp:include page="control-bar.jsp" />


	<!-- USER NAME  -->
	<div class= "header" >
	<%if (User.isDeletedUser(user.getUsername())) {%>
		<h1>This user is currently deactivated</h1></div>
	<%} else { %>
	<h1> 
	<%= name %>  
	</h1>
	</div>


	<div class = "backpanel">
	
	<!--  MESSAGES -->
		<div class = "panel" > 
		
		<h3> Send <%=name %> a Message </h3>
		
		
			
			<form action="sendMessageServlet" method="post">
			<select name = "messageType">
		  		<option value="note">Note</option>
		 		 <option value="challenge">Challenge</option>
			</select> <p></p>
				<input type = "hidden" name = "to" value=<%=name%> />
				<span class = "buttonspan"> 
					<input type= "submit"  value="Compose" id="submitbutton" /> </span> 
			</form>
			
			
			
		</div>
	
		<div class = "panel" >
			<div class = "panelcontent">
				<h3> Quiz Taking History </h3>
				
				<% 
				ArrayList<QuizTaken> quizTaken = user.getQuizHistory();
				int size = Math.min(quizTaken.size(), 3);
				if (size > 0) {
					out.println("<ul>");
					for (int i = 0; i < size; i++) {
						QuizTaken qt = quizTaken.get(i);
						Quiz q = qt.getQuiz();
						int id = q.getQuizId();
					%>
					<li> <a id="link" href="QuizSummary.jsp?id=<%=id%>"> <%= q.getName() %> </a> </li>
					<% } %>
					</ul>
				<% } else {
					out.println("No Quizzes Taken Yet.");
				}%>
				<h3> Quiz Creating History </h3>
				<% 
				ArrayList<Quiz> quizC = user.getQuizCreated();
				size = Math.min(quizC.size(), 3);
				if (size > 0) {
					out.println("<ul>");
					for (int i = 0; i < size; i++) {
						Quiz q = quizC.get(i);
						int id = q.getQuizId();
					%>
					<li> <a id="link" href="QuizSummary.jsp?id=<%=id%>"> <%= q.getName() %> </a> </li>
					<% } %>
					</ul>
				<%} else {
					out.println("No Quizzes Created Yet.<br><br>");
					}
				%>
			</div><br>
			<div class = "seeall" id="second-panel"> 
			<% String urlname = "displayAll.jsp?username=" + user.getUsername() + "&action=getHistory"; %>
				<a class ="seealllink" href = <%=urlname%>> View All </a>
			</div>
		</div>

		<!-- ACHIEVEMENT HISTORY -->
		<div class = "panel" >
				<div class = "panelcontent">
				<h3> Achievements </h3>
				
				<% 
				ArrayList<String> achievements = user.getAchievements();
				size = Math.min(achievements.size(), 3);
				if (size > 0) {
					out.println("<ul>");
				for (int i = 0; i<size; i++) {
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
				} else {
					out.println("No Achievements Earned Yet.<br><br>");
				}%>
				</ul>
				</div><br>
			<div class = "seeall" id="third-panel"> 
			<% urlname = "displayAll.jsp?username=" + user.getUsername() + "&action=getAchievements"; %>
				<a class ="seealllink" href = <%=urlname%>> View All</a>
			</div>
		</div>

		<!-- USER FRIENDS -->
		<div class = "panel" >
			<div class = "panelcontent">
				<h3> Friends </h3>
				
				<%
				ArrayList<String> friends = user.getFriends();
				size = Math.min(friends.size(), 3);
				if (size > 0) {
					out.println("<ul>");
						for (int i = 0; i < size; i++) {
							String f = friends.get(i);
						%>
						<li> <a id="link" href="UserProfile.jsp?username=<%=f%>"> <%= f %> </a> </li>
						<% } %>
						</ul>
					<% } else {
						out.println("No Friends Yet.<br><br>");
					}
					%>
				</div><br>
			<div class = "seeall" id="fourth-panel"> 
				<% urlname = "displayAll.jsp?username=" + user.getUsername() + "&action=getFriends"; %>
				<a class ="seealllink" href =<%=urlname%>> View All </a>
				
			</div>
		</div>
	</div>
	
	

	<!--  COOL BOX -->
	<div class ="header">
	</div>

	<% if (!currentUser.getUsername().equals(user.getUsername())) { %>
		<!--  FRIEND STATUS BUTTON -->
		<div class = "friendbutton">
			
			<!-- needs to pull current viewer.isFriendsWith current profile name -->
			<!-- DO ACTION WITH BUTTON! -->
			<% if (currentUser.isFriendsWith(user.getUsername())) { %>
				<p id="friendbutton" onclick="removeFriendship('<%= user.getUsername() %>')">Remove Friendship</p>
			<% } else if (currentUser.hasPendingFriendshipWith(user.getUsername())) { %>
				<p id="friendbutton">
					Friend Request:
					<a href="#friendbutton" onclick="acceptFriendRequest('<%= user.getUsername() %>')">Accept</a>
					<a href="#friendbutton" onclick="rejectFriendRequest('<%= user.getUsername() %>')">Reject</a>
				</p>
			<% } else if (user.hasPendingFriendshipWith(currentUser.getUsername())) { %>
				<p id="friendbutton">Friend Request Pending</p>
			<% } else if (currentUser.getUsername().equals(user.getUsername())) { %>
				<%-- nothing --%>
			<% } else { %>
				<p id="friendbutton" onclick="addFriend('<%= user.getUsername() %>')">Add Friend</p>
			<% } %>
	
		</div>
	<% } %>
<%} %>

</div>

</body>
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

</html>