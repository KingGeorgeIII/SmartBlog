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


 <a href="blog.jsp">Return to main</a>
  

<%

    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "default";

    }

    pageContext.setAttribute("guestbookName", guestbookName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user == null) {

      pageContext.setAttribute("user", user);
      %>
      <p> Please <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a> </p>|
     <%
    } else {
    	 %>
    	 
        <form action="/ofysign" method="post">
        <p> Title </p>|
          <div><textarea name="title" rows="1" cols="60"></textarea></div>
    	<p> Content </p>
          <div><textarea name="content" rows="3" cols="60"></textarea></div>

          <div><input type="submit" value="Post" /></div>

          <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

        </form>
 <%
    }

%>


 

  </body>

</html>

