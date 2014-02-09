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
            <span class="icon-bar"></span>
          </button>
          <div class="navbar-brand">UCLA Translate Flashcards</div>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="home.jsp">Home</a></li>
            <li><a href="about.html">About</a></li>
            <li><a href="tutorial.html">Get Started</a></li>

            <%
              if (user == null) {
            %>
            
                <li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign In</a></li>

            <%
              } else {
            %>

                <li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a></li>

            <%
              }
            %>
            
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <%
      if (user != null) {
    %>
    
      <div class="container">
        <div class="row">
        
          <!-- Begin one deck -->
          <div class="col-md-3">
            <a href="quiz.html?name=Food"><div class="row deck">Food</div></a>
            <div class="row deck-buttons"><button type="button" class="btn btn-primary" onclick="window.location.href='deck.html?name=Food'">Edit</button>&nbsp; &nbsp;<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#delete-food">Delete</button></div>
          </div>
          
          <div class="modal fade" id="delete-food" tabindex="-1" role="dialog" aria-labelledby="delete-food-label" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <h4 class="modal-title" id="delete-food-label">Are you sure you want to delete the deck &quot;Food&quot;?</h4>
                </div>
                <div class="modal-body">
                  <p>Once you delete this deck, it may be impossible to retrieve this information again.</p>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                  <button type="button" class="btn btn-danger">Delete</button>
                </div>
              </div>
            </div>
          </div>
          <!-- End one deck -->
          
          <!-- All other decks will have similar structure, but must be dynamically generated -->
          <div class="col-md-3"><div class="row deck">Animals</div><div class="row deck-buttons"><button type="button" class="btn btn-primary">Edit</button>&nbsp; &nbsp;<button type="button" class="btn btn-danger">Delete</button></div></div>
          <div class="col-md-3"><div class="row deck">Greetings</div><div class="row deck-buttons"><button type="button" class="btn btn-primary">Edit</button>&nbsp; &nbsp;<button type="button" class="btn btn-danger">Delete</button></div></div>
          <div class="col-md-3"><div class="row deck">Colors</div><div class="row deck-buttons"><button type="button" class="btn btn-primary">Edit</button>&nbsp; &nbsp;<button type="button" class="btn btn-danger">Delete</button></div></div>
        </div>
        <div>
          <div class="col-md-3"><div class="row deck">Weather</div><div class="row deck-buttons"><button type="button" class="btn btn-primary">Edit</button>&nbsp; &nbsp;<button type="button" class="btn btn-danger">Delete</button></div></div>
          <div class="col-md-3"><div class="row deck">Clothing</div><div class="row deck-buttons"><button type="button" class="btn btn-primary">Edit</button>&nbsp; &nbsp;<button type="button" class="btn btn-danger">Delete</button></div></div>
          <a href="deck.html?add=1"><div class="col-md-3"><div class="row add-deck"><img src="images/add_deck.png" alt="add a deck"></div></div></a>
      </div>

        <!--
      <div class="container">
        <div class="row">
          <a href="quiz.html?name=Food"><div class="col-md-3 deck">Food</div></a>
          <a href="quiz.html?name=Animals"><div class="col-md-3 deck">Animals</div></a>
          <a href="quiz.html?name=Greetings"><div class="col-md-3 deck">Greetings</div></a>
          <a href="quiz.html?name=Colors"><div class="col-md-3 deck">Colors</div></a>
        </div> 
        <div class="row">
          <a href="quiz.html?name=Weather"><div class="col-md-3 deck">Weather</div></a>
          <a href="quiz.html?name=Clothing"><div class="col-md-3 deck">Clothing</div></a>
          <a href="deck.html?add=1"><div class="col-md-3"><img src="images/add_deck.png" alt="add a deck"></a>
        </div> 
      </div>
      -->

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>

    <%
    }
    %>
  </body>
</html>