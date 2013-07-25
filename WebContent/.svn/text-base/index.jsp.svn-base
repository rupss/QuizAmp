<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="Users.User"%>
<%
	User currentUser = (User) request.getSession().getAttribute("currentUser");
	if (currentUser != null) {
		request.getRequestDispatcher("dashboard.jsp").forward(request, response);
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="stylesheets/application.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/login.css" />
    <title>Login</title>
</head>
<body>
    <div class="front-image">
        <img src="images/logo.png" alt="Smiley face" width="450px">
    </div>

    <div class="login-box">
        <p id="title-text">Turn your brain up to 11!</p>
        <form action="LoginServlet" method="post" id="login-form">
            <fieldset>
                <span class="login-label">Username</span>
                <input type="text" name="username" class="login-input">
                <br/>
            </fieldset>
            <fieldset>
                <span class="login-label">Password: </span>
                <input type="password" name="password" class="login-input">
                <br/>
            </fieldset>
            <div class="logindiv">
                <input type="submit" value="Enter" id="login">
            </div>
            <br/>
            New Here? <a href="addUser.jsp">Create an new account</a>
            <br/>
            Want to Get a Sneak Peak? <a href="selectQuiz.jsp">Browse Quizzes</a>
        </form>
        
    </div>
</body>
</html>