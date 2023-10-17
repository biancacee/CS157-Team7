<%@ page import="java.sql.*"%>
<html>
    <head>
        <title>ClubSpartan</title>
    
        <!-- Includes -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
    <body>
        <!-- Navbar -->
        <nav style="background-color:#687494">
            <div class="nav-wrapper container">
              <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="log-in">Log In</a></li>
                <li><a href="signup.jsp">Sign Up</a></li>
              </ul>
            </div>
        </nav>

        <!-- Home -->
        <div class="container">
            <%
            try 
            {
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "MySql.0189");
            %>
            <%


                con.close();
            }
            catch(SQLException e) 
            {
                out.println("SQLException caught: " + e.getMessage());
            }
            %>
        </div>
        <div class="container">
            <div class="row">
                <form class="col s12" action="review.jsp" method="post">
                    <div class="row">
                        <div class="input-field col s6">
                            <input name="title" id="title" type="text" class="validate">
                            <label for="title">Title</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <textarea name="description" id="description" class="materialize-textarea"></textarea>
                            <label for="description">Input text here</label>
                        </div>
                    </div>
                    <button class="btn btn-primary btn-sm" type="submit" name="action">Submit Review
                        <i class="material-icons right">send</i>
                    </button>
                </form>
        <script type="text/javascript" src="js/materialize.min.js"></script>
    </body>
</html>

