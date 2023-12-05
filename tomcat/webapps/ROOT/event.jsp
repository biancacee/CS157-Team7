<%@ page import="java.sql.*"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<html>
<head>
    <title>ClubSpartan</title>

    <!-- Includes -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

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

stmtQuery = "SELECT amentity_id, image, name FROM amentities";
PreparedStatement stmtAmentitiesAll = con.prepareStatement(stmtQuery);
ResultSet listAmentities = stmtAmentitiesAll.executeQuery();

stmtQuery = "SELECT * FROM moderates WHERE user_id = ? AND club_id = ?";
PreparedStatement stmtIsMod = con.prepareStatement(stmtQuery);
stmtIsMod.setString(1, user_id);
stmtIsMod.setString(2, club_id);
ResultSet rsIsMod = stmtIsMod.executeQuery();
boolean isModerator = rsIsMod.next();

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
    <% if(isModerator) { %>
        <a class="waves-effect waves-light btn modal-trigger" style="background-color: #687494" href="#modalAdd"><i class="material-icons left">note_add</i>Add Amentity</a>
        <a class="waves-effect waves-light btn modal-trigger" style="background-color: #687494" href="#modalCreate"><i class="material-icons left">build</i>Create Amentity</a>
    <% } %>
    <!-- Modal Add -->
    <div>
    <div id="modalAdd" class="modal">
        <div class="modal-content">
            <h1>Add Amentity</h1>
            <form id="addForm">
                <label for="amentity_id">Type:</label>
                <div class="input-field col s12 m6">
                    <select id="select" class="icons">
                      <% while(listAmentities.next()) { %>
                      <option value=<%= listAmentities.getString(1) %> data-icon=<%= listAmentities.getString(2) %>><%= listAmentities.getString(3) %></option>
                      <% } %>
                    </select>
                </div>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <button type="submit" class="waves-effect waves-light btn">Add</button>
            </form>
            <div id="response"></div>
        </div>
    </div>
    <!-- Modal Create -->
    <div>
    <div id="modalCreate" class="modal">
        <div class="modal-content">
            <h1>Create Amentity</h1>
            <form id="createForm" enctype="multipart/form-data" action="createAmentity.jsp" method="post">
                <label for="name">Name:</label>
                <textarea id="name" name="name" required></textarea><br>
                <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea><br>
                <input id="redirectPth" name="redirectPth" value=<%= request.getServletPath() + "?" + request.getQueryString() %> type="hidden"></input><br>
                <div class="file-field input-field">
                    <div class="btn">
                        <span>Upload Picture</span>
                        <input type="file" name="picture" required>
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text">
                    </div>
                </div>
                <br>
                <button type="submit" class="waves-effect waves-light btn">Submit</button>
            </form>
        <div id="response"></div>
    </div>
    </div>
    <% while(resultAmentities.next()) {%>
    <ul class="collection with-header">
        <li class="collection-item avatar">
            <img src=<%= resultAmentities.getString(3) %> alt="" class="circle">
            <p><%=resultAmentities.getString(4)%></p>
            <p><%=resultAmentities.getString(5)%></p>
            <% if(isModerator) { %>
            <a onclick=<%= "removeAmentity(" + resultAmentities.getString(1) + "," + event_id + ")" %> class="secondary-content delete_mod"><i class="material-icons">delete</i></a>
            <% } %>
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
listAmentities.close();
stmtAmentitiesAll.close();
stmtIsMod.close();
rsIsMod.close();
%>
</div>

<script type="text/javascript" src="js/materialize.min.js"></script>

<script>
    function removeAmentity(amentity_id, event_id)
    {
        $.ajax({
            type: 'POST',
            url: 'removeAmentity.jsp',
            data: {
                amentity_id: amentity_id,
                event_id: event_id,
            },
            success: function(response) {
                location.reload()
                $('#response').html(response);
            },
            error: function() {
                $('#response').html('An error occurred.');
            }
        });
    }
</script>

<!-- create -->
<script>
    $(document).ready(function() {
    $('#modalCreate').modal();
});
</script>

<!-- Add -->
<script>
    $(document).ready(function() {
    $('#modalAdd').modal();

    $('#addForm').submit(function(e) {
        e.preventDefault();
        var urlParams = new URLSearchParams(window.location.search);

        var amentity_id = $('#select').val();
        var event_id = urlParams.get('event_id');

        $.ajax({
            type: 'POST',
            url: 'addAmentity.jsp',
            data: {
                amentity_id: amentity_id,
                event_id: event_id,
            },
            success: function(response) {
                location.reload()
                $('#response').html(response);
            },
            error: function() {
                $('#response').html('An error occurred.');
            }
        });
    });
});

$(document).ready(function(){
    $('.modal').modal();
});

$(document).ready(function(){
    $('select').formSelect();
  });
</script>
</body>
</html>