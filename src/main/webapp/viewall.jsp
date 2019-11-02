<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.googlecode.objectify.Key"%>
<%@ page import=" com.googlecode.objectify.annotation.Entity" %>
<%@ page import=" com.googlecode.objectify.annotation.Id" %>
<%@ page import=" com.googlecode.objectify.annotation.Index" %>
<%@ page import=" com.googlecode.objectify.annotation.Parent" %>

<%@ page import=" com.googlecode.objectify.Objectify " %>

<%@ page import=" com.googlecode.objectify.ObjectifyService " %>

<%@ page import="java.util.Collections" %>

<%@ page import ="guestbook.Greeting" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html>

  <head>
<link type="text/css" rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <link type="text/css" rel="stylesheet" href="stylesheets\main.css" />
 


 </head>

 

  <body class = "w3-light-blue">
  
  <div class="hero-image">
  <div class="hero-text">
    <h1>Fresh Blog</h1>
    <p>Let's talk about water</p>
  </div>
</div>

 

  <body>

 <div class="w3-container w3-teal">
 <h3>
	<a href="blog.jsp"> <button class="w3-button w3-teal">Return to main </button></a>
  

<%

    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "default";

    }

    pageContext.setAttribute("guestbookName", guestbookName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

 <a href="makepost.jsp" ><button class="w3-button w3-teal">Make post </button></a>
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">
 <button class="w3-button w3-teal">Sign out</button></a>

<%

    } else {

%>

 <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">
 <button class="w3-button w3-teal">Sign in</button></a>


<%

    }

%>
 
  </h3>
 </div>
 <div class="w3-container w3-light-blue">

<%



    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

ObjectifyService.register(Greeting.class);

List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();   

Collections.sort(greetings); 

    if (greetings.isEmpty()) {

        %>

        <h2>Blog has no messages.</h2>

        <%

    } else {

        %>

        <h2>All Posts</h2>

        <%

        for (Greeting greeting : greetings) {
        	pageContext.setAttribute("greeting_title",

                    greeting.getTitle());

            pageContext.setAttribute("greeting_content",

                                     greeting.getContent());

            String guser;
            Long gid = greeting.getId();

            if (greeting.getUser() == null) {
            	guser = "anonymous";

            } else {

                pageContext.setAttribute("greeting_user",

                                         greeting.getUser() );
                guser = greeting.getUser().getNickname();

            }

            %>
			<div class="w3-card-4">
			<a style="text-decoration:none" href=<%= "\"viewpost.jsp?&title=" + greeting.getTitle() + "&id=" + gid
			+ "&guser=" + guser + "\"" %> >
			<header class="w3-container w3-blue">
  				<h5><b>${fn:escapeXml(greeting_title)}</b> by ${fn:escapeXml(greeting_user.nickname)}</h5>
			</header>
			<div class="w3-container">
  			<p>${fn:escapeXml(greeting_content)}</p>
			</div>
			</a>
			</div>
			<br>

            <%

        }

    }

%>


 </div>

  </body>

</html>

