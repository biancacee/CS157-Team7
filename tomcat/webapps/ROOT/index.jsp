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
        <% Connection con1 = null;
        try{
            int user_id = -1;
            if(session.getAttribute("user_id") != null)
            {
                user_id = (int)session.getAttribute("user_id");
            }
            Class.forName("com.mysql.jdbc.Driver");
            con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");
            String stmtQueryMod1 = "SELECT club_id FROM moderates WHERE user_id = ?;";
            PreparedStatement isModerator1 = con1.prepareStatement(stmtQueryMod1);
            isModerator1.setInt(1, user_id);
            ResultSet boolMod1 = isModerator1.executeQuery();
        %>
        <nav style="background-color:#687494">
            <div class="nav-wrapper container">
              <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="index.jsp">Home</a></li>
                <% if(session.getAttribute("user_id") == null){ %>
                <li><a href="login.jsp">Log In</a></li>
                <li><a href="signup.jsp">Sign Up</a></li>
                <% } %>

                <% if(session.getAttribute("user_id") != null){ %>
                    <li><a href="userProfile.jsp">Profile</a></li>
                    <li><a href="club_create.jsp">Create Club</a></li>
                    <li><a href="messages.jsp">Messages</a></li>
                    <% if(boolMod1.next()) {%>
                    <li><a href="moderator.jsp">Manage Clubs</a></li>
                    <% } %>
                    <li><a href="logout.jsp">Logout</a></li>
                <% } %>
                
              </ul>
            </div>
        </nav>
        <% 
        boolMod1.close();
        isModerator1.close();

        con1.close();
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (con1 != null) {
                        con1.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

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
                            <button class="btn-floating btn-large waves-effect waves-light" style="background-color:#687494" type="submit"><i class="material-icons left">search</i>Seach</button>
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
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

                    PreparedStatement stmt = con.prepareStatement("SELECT club_id, name, logo, description, is_active FROM club");
                    if(club_name != null)
                    {
                        stmt = con.prepareStatement("SELECT club_id, name, logo, description, is_active FROM club WHERE club.name LIKE ?");
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
                    <% if(rs.getInt(5) > 0) { %>
                        <a class="secondary-content"><i class="material-icons tiny" style="color: green;">brightness_1</i></a>
                    <% } else { %>
                        <a class="secondary-content"><i class="material-icons tiny" style="color: red;">brightness_1</i></a>
                    <% } %>
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