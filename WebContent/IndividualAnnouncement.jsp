<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheets/display.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<link rel="stylesheet" type="text/css"
	href="stylesheets/IndividualMessage.css" />
<title><%@ page import="Users.*, java.util.*, quiz.*"%>

	<%
		User user = (User) request.getSession().getAttribute("currentUser");
		String username = user.getUsername();
		String fromUsername = request.getParameter("from");
		String title = request.getParameter("title");
		String time = request.getParameter("time");
		String text = request.getParameter("content");
		//Announcement ann = user.
	%> See Announcement from <%
		out.println(fromUsername);
	%></title>
</head>
<body>
	<div class="bodyclass">
		<jsp:include page="control-bar.jsp" />
		<div class="header">
			<h1>ANNOUNCEMENT: 
			<% out.println(title); %></h1>
		</div>
		<div class="backpanel">
			<p>
				<span class="type">From:&nbsp;</span>
				<%
					String userProfileLink = "<a href=UserProfile.jsp?username=" + fromUsername + ">" + fromUsername + "</a>";
					out.println(userProfileLink);
				%>
			</p>
			<p>
				<span class="type">When:&nbsp;</span>
				<%
					out.println(time.substring(0, time.length() - 3));
				%>
			</p>
			<p>
				<span class="type">Text:&nbsp;</span>
				<%
					out.println(text);
				%>
			</p>
		</div>
	</div>
</body>
</html>