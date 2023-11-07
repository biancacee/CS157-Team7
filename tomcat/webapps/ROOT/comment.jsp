<%@ page import="java.sql.*"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
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
            <% if(session.getAttribute("user_id") == null){ %>
            <li><a href="login.jsp">Log In</a></li>
            <li><a href="signup.jsp">Sign Up</a></li>
            <% } %>

            <% if(session.getAttribute("user_id") != null){ %>
            <li><a href="logout.jsp">Logout</a></li>
            <% } %>
        </ul>
    </div>
</nav>
<!-- Home -->
<div class="container">
    <%
            String user_id = request.getParameter("user_id");
            String review_id = request.getParameter("review_id");
            String message = request.getParameter("message");
        try
        {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

            PreparedStatement ps = con.prepareStatement("insert into comment(user_id,review_id,message) VALUES (4,1,?)");

            //ps.setString(1, user_id);
            //ps.setString(2, review_id);
            ps.setString(1, message);

            int x = ps.executeUpdate();

            if (x > 0)
            {
                    %>
                            <h4 class="center-align">Comment Added</h4>
                    <%
            }
            ps.close();
            con.close();
        }
        catch (SQLException e)
             {
                out.println("Error: " + e.getMessage());
                e.printStackTrace(); // Log the stack trace for more information
            }
    %>
    <div class="row">
        <form action= "comment.jsp" method="post" class="col s12" >
            <div class="row">
                <div class="input-field col s12">
                    <textarea name="message"  id="message" class="materialize-textarea"></textarea>
                    <label for="message">Textarea</label>
                </div>
                <button class="btn btn-primary btn-sm" type="submit" >Submit
                    <i class="material-icons right">send</i>
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
