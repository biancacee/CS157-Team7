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
<% 
String event_id = request.getParameter("event_id");
String user_id = request.getParameter("user_id");
String club_id = request.getParameter("club_id");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

String stmtQuery = "SELECT * FROM event WHERE event_id = ?;";
PreparedStatement stmt = con.prepareStatement(stmtQuery);
stmt.setString(1, event_id);
ResultSet result = stmt.executeQuery();

stmtQuery = "SELECT DISTINCT * FROM event_includes NATURAL JOIN amentities WHERE event_id = ?";
PreparedStatement stmtAmentities = con.prepareStatement(stmtQuery);
stmtAmentities.setString(1, event_id);
ResultSet resultAmentities = stmtAmentities.executeQuery();

while(result.next())
{
%>
<div style="background-color:#e9ecee">
    <div class="container" style="padding: 15px;">
        <h4><%=result.getString(4)%></h4>
        <div class="row">
            <div>
                <div><b>Location: </b><%=result.getString(3)%></div>
                <div><b>Start Date: </b><%=result.getString(6)%></div>
                <div><b>Start Time: </b><%=result.getString(7)%></div>
                <div><b>End Time: </b><%=result.getString(8)%></div>
                <hr />
                <p><%=result.getString(5)%></p>

            </div>
        </div>
    </div>
</div>
<div class="container" style="padding: 15px;">
    <h5>Amentities</h5>
    <a class="waves-effect waves-light btn modal-trigger" style="background-color: #687494" href="#modalAdd"><i class="material-icons left">note_add</i>Add Amentity</a>
    <a class="waves-effect waves-light btn modal-trigger" style="background-color: #687494" href="#modalCreate"><i class="material-icons left">build</i>Create Amentity</a>

    <% while(resultAmentities.next()) {%>
    <ul class="collection with-header">
        <li class="collection-item avatar">
            <img src=<%= resultAmentities.getString(3) %> alt="" class="circle">
            <p><%=resultAmentities.getString(4)%></p>
            <p><%=resultAmentities.getString(5)%></p>
            <a onclick=<%= "removeAmentity(" + resultAmentities.getString(1) + "," + club_id + ")" %> class="secondary-content"><i class="material-icons">delete</i></a>
        </li>
    </ul>
    <% } %>
</div>
<%
}
stmtAmentities.close();
resultAmentities.close();
stmt.close();
result.close();
%>
<script type="text/javascript" src="js/materialize.min.js"></script>

<script>
    function removeAmentity(amentity_id, club_id)
    {
        console.log(amentity_id, club_id);
    }
</script>
</body>
</html>