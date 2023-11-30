<%@ page import="java.sql.*"%>
<html>
<head>
    <title>ClubSpartan</title>

    <!-- Includes -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <!-- used for dropdown sent/received message -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
<!-- Navbar -->
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
<div class="divider"></div>
<div class="section">
<div class="container">
<a class="dropdown-trigger btn" href="#" data-target="dropdown1">Sort Messages</a>
<ul id="dropdown1" class="dropdown-content">
    <li><a href="#!">Inbox</a></li>
    <li><a href="#!">Outbox</a></li>
</ul>
</div>
</div>
<div class="container">

<%
    try
    {
        String currentUserId = request.getParameter("user_id");
        int itemsPerPage = 5;
        int currentPage = 1;

        String currentPageParam = request.getParameter("page");
        if (currentPageParam != null) {
            currentPage = Integer.parseInt(currentPageParam);
        }

        int startItem = (currentPage - 1) * itemsPerPage;

        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

        PreparedStatement stmt = con.prepareStatement("SELECT message_id, sender_id, receiver_id, message, time_stamp FROM private_message ORDER BY time_stamp DESC LIMIT ?, ?");

        stmt.setString(1, currentUserId);
        stmt.setInt(1, startItem);
        stmt.setInt(2, itemsPerPage);

        ResultSet rs = stmt.executeQuery();

        while(rs.next())
        {
%>
<ul class="collection">
    <li class="collection-item avatar">
        <img src="images/yuna.jpg" alt="" class="circle">
        <span class="title"><%= rs.getString("sender_id") %></span>
        <p><%= rs.getString("message") %></p>
        <p class="secondary-content"><%= rs.getString("time_stamp") %></p>
    </li>
</ul>
<%
        }
            rs.close();
            stmt.close();

            PreparedStatement countStmt = con.prepareStatement("SELECT COUNT(*) as total FROM private_message");
            ResultSet countRs = countStmt.executeQuery();
            countRs.next();
            int totalItems = countRs.getInt("total");
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            countRs.close();
            countStmt.close();
            con.close();
%>

</div>
<div class="container">
    <ul class="pagination">
        <li class="<%= (currentPage == 1) ? "disabled" : "waves-effect" %>">
            <a href="<%= (currentPage == 1) ? '#' : "?page=" + (currentPage - 1) %>">
                <i class="material-icons">chevron_left</i>
            </a>
        </li>
        <% for (int i = 1; i <= totalPages; i++) { %>
        <li class="<%= (currentPage == i) ? "active" : "waves-effect" %>">
            <a href="<%= "?page=" + i %>" ><%= i %></a>
        </li>
        <% } %>
        <li class="<%= (currentPage == totalPages || totalPages == 0) ? "disabled" : "waves-effect" %>">
            <a href="<%= (currentPage == totalPages || totalPages == 0) ? '#' : "?page=" + (currentPage + 1) %>">
                <i class="material-icons">chevron_right</i>
            </a>
        </li>
    </ul>
</div>
<%
    }
    catch (SQLException | ClassNotFoundException e)
    {
    out.println("Exception caught: " + e.getMessage());
    }
%>
<div class="fixed-action-btn">
    <a class="btn-floating btn-large red" id="main-btn">
        <i class="large material-icons">mode_edit</i>
    </a>
</div>

<div id="message-modal" class="modal">
    <div class="modal-content">
        <h4>Compose Message</h4>
        <div class="row">
            <form class="col s12">
                <div class="row">
                    <div class="input-field col s12">
                        <textarea id="textarea2" class="materialize-textarea" data-length="120"></textarea>
                        <label for="textarea2">Textarea</label>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="modal-footer">
        <div class="modal-footer">
            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Send</a>
            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Close</a>
        </div>
    </div>
</div>

<script>
    //messages
    document.addEventListener('DOMContentLoaded', function()
    {
        var elems = document.querySelectorAll('.modal');
        var instances = M.Modal.init(elems);

        document.getElementById('main-btn').addEventListener('click', function()
        {
            var modalInstance = M.Modal.getInstance(document.getElementById('message-modal'));
            modalInstance.open();
        });
    });
    //message
    $(document).ready(function() {
        $('input#input_text, textarea#textarea2').characterCounter();
    });

    //dropdown inbox,outbox
    document.addEventListener('DOMContentLoaded', function() {
        var elems = document.querySelectorAll('.dropdown-trigger');
        var instances = M.Dropdown.init(elems, {});
    });
</script>
</body>
</html>

