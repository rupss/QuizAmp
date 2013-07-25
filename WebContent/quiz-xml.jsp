<%@ page language="java" contentType="text/xml; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%><%@ page import="Users.*, quiz.*" %><%
	Quiz quiz = Quiz.readDB(Integer.parseInt(request.getParameter("id")));
	User currentUser = (User) request.getSession().getAttribute("currentUser");
	if (!quiz.canSeeXML(currentUser)) {
		response.sendError(403); // access forbidden
	}
%><?xml version="1.0" encoding="ISO-8859-1" ?>
<%= quiz.toXML() %>