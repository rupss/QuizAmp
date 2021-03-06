<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheets/display.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<title>Send Note</title>
</head>

<%@ page
			import="Users.User, java.util.*, quiz.*, java.net.URL"%>

<%  
	String name = request.getParameter("to");
	String upperName = name.toUpperCase();
	User currentUser = (User) request.getSession().getAttribute("currentUser"); // TODO: boot if not logged in
	%>
<div class = "bodyclass">

<jsp:include page="control-bar.jsp" />

	<body>



	<div class = "header" >
	
	<h1> SEND NOTE TO <%=upperName%> </h1>
	
	</div>
	
	<div class = "backpanel"> 
	
	<form action="processNoteServlet" method="post">
				
					<input type = "hidden" name = "to" value = <%=name %>>
					<input type = "hidden" name = "from" value = <%=currentUser.getUsername() %>>
					<textarea cols = "139" rows = "15" name = "message" ></textarea>
					<span class = "buttonspan"> 
						<input type= "submit"  value="Send" id="submitbutton" /> </span> 
				</form>
	
	
	</div>
	
	</body>
</div>
</html>