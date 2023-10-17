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
                <li><a href="sign-up">Sign Up</a></li>
              </ul>
            </div>
        </nav>

        <%
        try 
        {
            String club_id = request.getParameter("club_id");

            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:"+"3306"+"/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

            PreparedStatement stmt = con.prepareStatement("SELECT * FROM club WHERE club_id = ?");
            stmt.setString(1, club_id);
            ResultSet rs = stmt.executeQuery();
            rs.next();

            
        %>

        <!-- Home -->
        <div class="container">
          <div style="background-color:#e9ecee">
            <div class="container center-align" style="padding: 15px;">
                <h4><%= rs.getString(2) %></h4>
            </div>
          </div>
            
        </div>

        <%
            rs.close();
            con.close();
        }
        catch(SQLException e) 
        {
            out.println("SQLException caught: " + e.getMessage());
        }
        %>

        <script type="text/javascript" src="js/materialize.min.js"></script>
    </body>
</html>