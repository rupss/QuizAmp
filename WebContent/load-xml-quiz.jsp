<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheets/application.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/controlBar.css" />
<link rel="stylesheet" type="text/css" href="stylesheets/quiz.css" />
<title>Create XML Quiz</title>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="control-bar.jsp" />
	
		<form action="load-xml-quiz" method="post">
			<p class="box" id="title">
				Quiz XML:<br />
				<textarea name="xml"></textarea><br />
				<input type="submit" value="Load Quiz" />
			</p>
		</form>
		
		<div class="panel">
			<div class="box">
				<h3>DTD:</h3> <!-- DTD mostly from the CS108 website -->
				<%-- TODO: category not implemented --%>
				<p>
				&lt;!ELEMENT quiz (title, description, question+)&gt;<br />
				&lt;!ATTLIST quiz<br />
					random		(true | false)		"true"<br />
					one-page	(true | false)		"true"<br />
					immediate-correction	(true | false)	"false"<br />
					practice-mode			(true | false)	"true"<br />
					seconds-per-quiz (default: 0)<br />
					&gt;<br />
				<br />
				&lt;!ELEMENT title (#PCDATA)&gt;<br />
				<br />
				&lt;!ELEMENT description (#PCDATA)&gt;	<br />
				<br />
				&lt;!ELEMENT question (((query | image-location | blank-query), (answer | answer-list))<br />
										| (query, option+))&gt;<br />
				&lt;!ATTLIST question <br />
					type (question-response | fill-in-blank | multiple-choice | picture-response | multiple-answer)  #REQUIRED<br />
					&gt;<br />
				<br />
				&lt;!ELEMENT query (#PCDATA)&gt;<br />
				&lt;!ELEMENT blank-query (pre, blank, post)&gt;<br />
				&lt;!ELEMENT pre (#PCDATA)&gt;<br />
				&lt;!ELEMENT post (#PCDATA)&gt;<br />
				&lt;!ELEMENT blank EMPTY&gt;<br />
				<br />
				&lt;!ELEMENT image-location (#PCDATA)&gt;<br />
				<br />
				&lt;!ELEMENT option (#PCDATA)&gt;<br />
				&lt;!ATTLIST option answer (answer) #IMPLIED&gt;<br />
				<br />
				&lt;!ELEMENT answer (#PCDATA)&gt;<br />
				&lt;!ATTLIST answer preferred (preferred) #IMPLIED&gt;<br />
				<br />
				&lt;!ELEMENT answer-list (answer)+&gt;<br />
				&lt;!ATTLIST answer-list ordered (true | false) #IMPLIED&gt;<br />
				</p>
			</div>
		</div>
	</div>
</body>
</html>