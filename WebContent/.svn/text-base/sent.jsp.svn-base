<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<link rel="stylesheet" type="text/css" href="stylesheets/display.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/centerimage.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<%@ page
			import="Users.User, java.util.*, quiz.*, java.net.URL"%>
<title>Sent</title>
</head>
<body>

<div class = "bodyclass">

<jsp:include page="control-bar.jsp" />


	<div class = "header">
		<h1> Sent </h1>
	</div>

<% User currentUser = (User) request.getSession().getAttribute("currentUser");
		String url = "dashboard.jsp?username=" + currentUser.getUsername();
		%>
		<a href=<%=url%>  > <img id = "image" src="images/logo.png" alt="Smiley face" width="450px"> </a>
		
	
	
	
</div>

</body>
</html>