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

 

  <body class = "w3-light-blue">

<div class="w3-container w3-teal">
 <h3>
 <a href="blog.jsp">
  <button class="w3-button w3-teal">Return to main</button>
  </a></h3>
</div>

<div class="w3-container w3-light-blue">
  

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
        <p> Title </p>
          <div><textarea name="title" rows="1" cols="60"></textarea></div>
    	<p> Body </p>
          <div><textarea name="content" rows="3" cols="60"></textarea></div>

          <div><a href = "blog.jsp"><input type="submit" value="Post" /></a></div>

          <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

        </form>
 <%
    }

%>


 </div>

  </body>

</html>

