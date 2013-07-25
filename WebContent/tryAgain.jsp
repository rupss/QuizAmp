<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<%@ page import="Users.User"%>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="stylesheets/application.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/login.css" />
    <title>Try Again</title>
</head>
<body>
    <div class="front-image">
   <a href="index.jsp"  > <img src="images/logo.png" alt="Smiley face" width="450px"> </a>
       
    </div>

    <div class="login-box">
        <p id="title-text">Those credentials are Incorrect</p>
        <p id="title-text">Please try again</p>
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
        </form>
        
    </div>
</body>
</html>