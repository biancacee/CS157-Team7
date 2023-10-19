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
            <li><a href="log-in">Log In</a></li>
            <li><a href="signup.jsp">Sign Up</a></li>
        </ul>
    </div>
</nav>
<!-- Home -->
<div class="container">
    <%
        // post request
            String sjsu_email = request.getParameter("sjsu_email");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String major = request.getParameter("major");


          try
            {
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "MySql.0189");

                PreparedStatement ps = con.prepareStatement("insert into user(sjsu_email,password,name,major) VALUES (?,?,?,?)");

                ps.setString(1,sjsu_email);
                ps.setString(2,password);
                ps.setString(3,name);
                ps.setString(4,major);

                int x = ps.executeUpdate();

                if (x>0)
                {
                    System.out.println("Registration done successfully");
                }

    %>
        <%
        con.close();
    }
    catch(SQLException e)
    {
        out.println("SQLException caught: " + e.getMessage());
    }
%>
    <div class="container">
        <form class="col s12" action = "signup.jsp" method="post">
            <div class="row">
                <div class="input-field col s6">
                    <input id="name" name="name" type="text" class="validate">
                    <label for="name">Enter Name</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <input id="major" name="major" type="text" class="validate">
                    <label for="major">Major</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <input id="password" name="password" type="password" class="validate">
                    <label for="password">Password</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <input id="sjsu_email" name="sjsu_email" type="email" class="validate">
                    <label for="sjsu_email">SJSU Email</label>
                </div>
            </div>
            <div class="row">
            <button class="btn btn-primary btn-sm" type="submit" name="action">Submit
                <i class="material-icons right">send</i>
            </button>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript" src="js/materialize.min.js"></script>
</body>
</html>