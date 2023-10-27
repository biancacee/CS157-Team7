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
            <li><a href="login.jsp">Log In</a></li>
            <li><a href="signup.jsp">Sign Up</a></li>
        </ul>
    </div>
</nav>
<!-- Home -->
<div class="container" style="margin-top: 40px;">
    <form class="col s12" action = "login.jsp" method="post">
        <div class="row">
            <div class="input-field col s12">
                <input id="sjsu_email" name="sjsu_email" type="email" class="validate">
                <label for="sjsu_email">SJSU Email</label>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s12">
                <input id="password" name="password" type="password" class="validate">
                <label for="password">Password</label>
            </div>
        </div>
        <div class="row">
        <button class="btn btn-primary btn-sm" type="submit" name="login.jsp">Submit
            <i class="material-icons right">send</i>
        </button>
        </div>
    </form>
    <%
        String sjsu_email = request.getParameter("sjsu_email");
        String password = request.getParameter("password");

        if(sjsu_email != null && password != null)
        {
            try
            {
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

                PreparedStatement ps = con.prepareStatement("SELECT user_id FROM user WHERE sjsu_email = ? and password = ?");

                ps.setString(1, sjsu_email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if (rs.next())
                {
                    session.setAttribute("user_id", rs.getInt(1));
                    response.sendRedirect("index.jsp");
                    %>
                    <h4 class="center-align">Login Done Successfully</h4>
                    <%
                }
                else
                {
                    %>
                    <h4 class="center-align">Invalid Email or Password</h4>
                    <%  
                }

                rs.close();
                ps.close();
                con.close();
            }
            catch(SQLException e)
            {
                out.println("SQLException caught: " + e.getMessage());
            }
        }
    %>
</div>
<script type="text/javascript" src="js/materialize.min.js"></script>
</body>
</html>