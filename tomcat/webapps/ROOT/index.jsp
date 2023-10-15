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
        <nav>
            <div class="nav-wrapper container">
              <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="log-in">Log In</a></li>
                <li><a href="sign-up">Sign Up</a></li>
              </ul>
            </div>
        </nav>

        <!-- Home -->
        <div class="container">
            <h2>ClubSpartan</h2>

            <!-- Seach Form -->
            <div class="row">
                <form class="col s12" action="index.jsp" method="get">
                    <div class="row">
                        <div class="input-field col s6">
                            <label for="name">Club Name</label>
                            <input id="name" name="club-name" type="text" class="validate" placeholder="Club Search...">
                        </div>
                        <div class="input-field col s6">
                            <button class="btn-floating btn-large waves-effect waves-light" type="submit"><i class="material-icons left">search</i>Seach</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- List of clubs -->
            <ul class="collection with-header">
            <%
                try 
                {
                    String club_name = request.getParameter("club-name");

                    java.sql.Connection con;
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:8889/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

                    PreparedStatement stmt = con.prepareStatement("SELECT club_id, name, logo, description, membership_fee, is_active FROM club");
                    if(club_name != null)
                    {
                    stmt = con.prepareStatement("SELECT club_id, name, logo, description, membership_fee, is_active FROM club WHERE club.name LIKE ?");
                    stmt.setString(1, "%" + club_name + "%");
                    }
                    ResultSet rs = stmt.executeQuery();

                    while(rs.next())
                {
            %>
                <li class="collection-item avatar">
                    <img src=<%= rs.getString(3) %> alt="" class="circle">
                    <a href=<%= "club.jsp?id=" + rs.getInt(1) %> class="title"><%= rs.getString(2) %></a>
                    <p><%= rs.getString(4) %></p>
                    <a class="secondary-content"><i class="material-icons">grade</i></a>
                </li>
            <%
                }

                    rs.close();
                    stmt.close();
                    con.close();
                }
                catch(SQLException e) 
                {
                    out.println("SQLException caught: " + e.getMessage());
                }
            %>
            </ul>
        </div>

        <script type="text/javascript" src="js/materialize.min.js"></script>
    </body>
</html>