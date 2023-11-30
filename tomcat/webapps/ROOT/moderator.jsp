<%@ page import="java.sql.*"%>
<html>
    <head>
        <title>Profile</title>
    
        <!-- Includes -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <!-- Needed for Modal Write review -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.12.0/css/tachyons.min.css"/>
        <link rel="stylesheet" type="text/css" href="style.css">

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
                    <li><a href="moderator.jsp">Moderator</a></li>
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
        <%
        Connection con = null;
        try 
        {
            int user_id = -1;
            if(session.getAttribute("user_id") != null)
            {
                user_id = (int)session.getAttribute("user_id");
            }
                
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

            PreparedStatement stmt = con.prepareStatement("SELECT * FROM user WHERE user_id = ?");
            stmt.setInt(1, user_id);
            ResultSet rs = stmt.executeQuery();
            rs.next(); // Move the cursor to the first row

            String userName = rs.getString("name");
            String email = rs.getString("sjsu_email");
            String id = rs.getString("user_id");
            
            String stmtQuery = "SELECT r.review_id, r.user_id, r.title, r.description, COUNT(l.user_id) AS like_count FROM review r LEFT JOIN `like` l ON r.review_id = l.review_id WHERE r.user_id = ? GROUP BY r.review_id ORDER BY like_count DESC";
            PreparedStatement stmt_review = con.prepareStatement(stmtQuery);
            stmt_review.setString(1, id);
            ResultSet rs_review = stmt_review.executeQuery();
        %>
        <div class="container">
            <h2>ClubSpartan</h2>
            
            
        </div>

        <% 
        rs.close();
        rs_review.close();
        
        stmt.close();
        stmt_review.close();

        con.close();
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
                
            
    </body>
</html>
