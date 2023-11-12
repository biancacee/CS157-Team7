<%@ page import="java.sql.*"%>
<html>
    <head>
        <title>Profile</title>
    
        <!-- Includes -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.12.0/css/tachyons.min.css"/>
        <link rel="stylesheet" type="text/css" href="style.css">

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
                    <li><a href="userProfile.jsp">Profile</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                <% } %>
              </ul>
            </div>
        </nav>
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
        %>
        <div class="container">
            <h2>ClubSpartan</h2>
            <!-- Home -->
            <div class="container center-align mb4 mt5 fw4" style="font-size: 2rem;">
                Hello, <%= userName %>
            </div>
            <div class="flex justify-center" >
                <div class="mr4 fw8" style="font-size: 1.3rem;"><a class="profileTabs" onclick="showContent('profile')">Profile</a></div>
                <div class="mr4 fw8" style="font-size: 1.3rem;"><a class="profileTabs" onclick="showContent('settings')">Account Settings</a></div>
                <div class="mr4 fw8" style="font-size: 1.3rem;"><a class="profileTabs" onclick="showContent('ratings')">Ratings</a></div>
            </div>
            <div class="flex justify-center">
                <div class="underline"></div>
            </div>
            <div class="flex justify-center">
                <div id="profile" class="content">
                    <div id="userInfo">
                        <p><strong>Name:</strong> <span id="userName"> <%= userName %> </span></p>
                        <p><strong>Email:</strong> <span id="userEmail"> <%= email %>  </span></p>
                        <button onclick="showEditForm()">Edit</button>
                      </div>
                    
                      <div id="editForm">
                        <form onsubmit="saveUserInfo(); return false;">
                          <label for="editName">Name:</label>
                          <input type="text" id="editName" required>
                          <button type="submit">Save</button>
                          <button type="button" onclick="cancelEdit()">Cancel</button>
                        </form>
                      </div>
                </div>
                
            
                <div id="settings" class="content">
                    <h2>Account Settings Content</h2>
                    <p>This is the account settings section.</p>
                </div>
            
                <div id="ratings" class="content">
                    <h2>Ratings Content</h2>
                    <p>This is the ratings section.</p>
                </div>
            </div>
        </div>

        <% 
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
        <script type="text/javascript" src="js/materialize.min.js"></script>
        <script>
            // JavaScript function to initialize the page
            function initializePage() {
                // Hide all content divs
                var contentDivs = document.querySelectorAll('.content');
                contentDivs.forEach(function(div) {
                    div.style.display = 'none';
                });
        
                // Show the default content (e.g., "Profile")
                var defaultContent = document.getElementById('profile');
                defaultContent.style.display = 'block';
            }
        
            // JavaScript function to show the selected content
            function showContent(contentId) {
                // Hide all content divs
                var contentDivs = document.querySelectorAll('.content');
                contentDivs.forEach(function(div) {
                    div.style.display = 'none';
                });
        
                // Show the selected content div
                var selectedContent = document.getElementById(contentId);
                selectedContent.style.display = 'block';
            }
        
            // Initialize the page on load
            document.addEventListener("DOMContentLoaded", function() {
                initializePage();
            });
        </script>
          <script>
            // Initially hide the editForm
            document.getElementById("editForm").style.display = "none";
        
            function showEditForm() {
              // Hide user info and show edit form
              document.getElementById("userInfo").style.display = "none";
              document.getElementById("editForm").style.display = "block";
        
              // Populate edit form with current user info
              document.getElementById("editName").value = document.getElementById("userName").innerText;
              document.getElementById("editEmail").value = document.getElementById("userEmail").innerText;
            }
        
            function cancelEdit() {
              // Show user info and hide edit form
              document.getElementById("userInfo").style.display = "block";
              document.getElementById("editForm").style.display = "none";
            }
        
            function saveUserInfo() {
              // Update user info with the values from the edit form
              document.getElementById("userName").innerText = document.getElementById("editName").value;
              document.getElementById("userEmail").innerText = document.getElementById("editEmail").value;
        
              // Show user info and hide edit form
              document.getElementById("userInfo").style.display = "block";
              document.getElementById("editForm").style.display = "none";
            }
          </script>
    </body>
</html>
