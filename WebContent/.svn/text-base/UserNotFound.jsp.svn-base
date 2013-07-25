<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheets/display.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/centerimage.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/searchbar.css" />
<%@ page
			import="Users.User, java.util.*, quiz.*, java.net.URL"%>
<title>User Not Found</title>
</head>
<body>

<div class = "bodyclass">

<jsp:include page="control-bar.jsp" />

	<div class = "search">
			
			<form action="displayUserResult" method="post">
				<span id = "text"> Search for User: </span> <input type="text" name="username" class="search-input"/>
				<span class = "buttonspan"> 
					<input type= "submit"  value="Search" id="searchbutton" /> </span> 

			</form>
			
			</div>
	<div class = "header">
		<h1> User Not Found</h1>
	</div>

<% User currentUser = (User) request.getSession().getAttribute("currentUser");
		String url = "index.jsp";
		%>
		<a href=<%=url%>  > <img id = "image" src="images/logo.png" alt="Smiley face" width="450px"> </a>
		
	
	
	
</div>

</body>
</html>