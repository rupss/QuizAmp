<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheets/display.css" />
<link rel="stylesheet" type="text/css"
	href="stylesheets/centerimage.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/searchbar.css" />
<%@ page import="Users.User, java.util.*, quiz.*, java.net.URL"%>
<title>Tag Not Found</title>
</head>
<body>

	<div class="bodyclass">

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
			<h1>Tag Not Found</h1>
		</div>

		<% 
		String url = "selectQuiz.jsp";
		%>
		<a href=<%=url%>> <img id="image" src="images/logo.png"
			alt="Smiley face" width="450px">
		</a>




	</div>

</body>
</html>