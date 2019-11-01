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
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
 </head>

 

  <body>

 

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
 <a href="makepost.jsp">Make post</a>

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign out</a>

<%

    } else {

%>

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

<%

    }

%>

 
 
 <a href="viewall.jsp">View all blog posts</a>

<%



    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

ObjectifyService.register(Greeting.class);

List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();   

Collections.sort(greetings); 

    if (greetings.isEmpty()) {

        %>

        <p>Guestbook '${fn:escapeXml(guestbookName)}' has no messages.</p>

        <%

    } else {

        %>

        <p>Messages in Guestbook '${fn:escapeXml(guestbookName)}'.</p>

        <%
		int count = 0;
        for (Greeting greeting : greetings) {
        	if(count++ >= 3){
        		break;
        	}
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
			<p><a href=<%= "\"viewpost.jsp?&title=" + greeting.getTitle() + "&id=" + gid
			+ "&guser=" + guser + "\"" %> >${fn:escapeXml(greeting_title)}</a></p>

            <%

        }

    }

%>


 

  </body>

</html>

