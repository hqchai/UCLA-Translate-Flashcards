<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Home | UCLA Translate Flashcards</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Hammersmith+One' rel='stylesheet' type='text/css'>
    
    <link rel="icon" type="image/jpg" href="images/icon.jpg">
  </head>

  <%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
  %>
  
  <body>
  
      <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="navbar-brand">UCLA Translate Flashcards</div>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="/home">Home</a></li>
            <li class="active"><a href="about.jsp">About</a></li>
            <li><a href="tutorial.jsp">Get Started</a></li>
          </ul>

          <% if (user != null) { %>

            <ul class="nav navbar-nav navbar-right">
              <li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a></li>
            </ul>

          <% } %>
        </div><!--/.nav-collapse -->
      </div>
    </div>
    
          <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h1>UCLA Translate Flashcards</h1>
        <p>UCLA Translate Flashcards will assist users in accomplishing their goal in learning phrases that they find valuable in another language. What makes UCLA Translate Flashcards different from other existing flashcard resources is that it is tailored to meet the individual needs of each and every user. Rather than generating a generic list of commonly translated phrases between two languages, UCLA Translate Flashcards will take the phrases that the user saves to their Phrasebook, and creates a personalized set of flashcards from this input. </p>
        <p>To interact with their flashcards, the user can update them: add, delete, categorize, modify, and rank the difficulty of each card. In addition, the user can input to UCLA Translate Flashcards a list of phrases they would like the application to translate and make the flashcards for them. Further, a user can organize their decks of flashcards by language, context, topic, or however they so desire. </p>
        <p>Through spaced repetition, the user does not just learn these phrases, they are committed to memory. To accomplish this, UCLA Translate Flashcards provides users with the ability to test their knowledge, assess the areas they need to focus on more through progress bars, and feel confident in the areas that they have mastered.</p>
      </div>
    
        <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
