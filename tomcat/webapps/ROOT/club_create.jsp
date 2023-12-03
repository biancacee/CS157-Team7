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
                user_id = (Integer)session.getAttribute("user_id");
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
        <div class="container">
            <h2 class="flex justify-center">Create a New Club</h2>
        </div>
        <div class="flex pt3 justify-center">
            <div class="w-50">
                <form class="col s12" id="clubForm" action="insert_Club.jsp" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="input-field col s6">
                            <input id="clubName" name="clubName" type="text" class="validate" required>
                            <label for="clubName">Club Name</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="clubDescription" name="clubDescription" type="text" class="validate" required>
                            <label for="clubDescription">Club Description</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="clubEmail" name="clubEmail" type="email" class="validate" required>
                            <label for="clubEmail">Club Email</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="discordLink" name="discordLink" type="text" class="validate">
                            <label for="discordLink">discord Link</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="instagramLink" name="instagramLink" type="text" class="validate">
                            <label for="instagramLink">Instagram Link</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="memberFee" name="memberFee" type="text" class="validate" value="0" required oninput="validateNumber(this)">
                            <label for="memberFee">Member Fee</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="file-field input-field">
                            <div class="btn">
                                <span>Upload Picture</span>
                                <input type="file" name="clubPicture" required>
                            </div>
                            <div class="file-path-wrapper">
                                <input class="file-path validate" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="flex justify-center row">
                        <button class="btn btn-primary btn-sm" type="submit" id="submitButton">Submit</button>
                    </div>  
                </form>
            </div>
        </div> 
        <script>
            function validateNumber(input) {
                // Remove any non-numeric characters
                let value = input.value.replace(/[^0-9]/g, '');
        
                // Update the input value
                input.value = value;
            }
        </script>               
    </body>
</html>
