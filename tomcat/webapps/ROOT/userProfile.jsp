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
            String id = rs.getString("user_id");
            
            String stmtQuery = "SELECT r.review_id, r.user_id, r.title, r.description, COUNT(l.user_id) AS like_count FROM review r LEFT JOIN `like` l ON r.review_id = l.review_id WHERE r.user_id = ? GROUP BY r.review_id ORDER BY like_count DESC";
            PreparedStatement stmt_review = con.prepareStatement(stmtQuery);
            stmt_review.setString(1, id);
            ResultSet rs_review = stmt_review.executeQuery();
        %>
        <div class="container">
            <h2>ClubSpartan</h2>
            <!-- Home -->
            <div class="container center-align mb4 mt5 fw4" style="font-size: 2rem;">
                Hello, <%= userName %>
            </div>
            <div class="flex justify-center" >
                <div class="mr4 fw8 info"><a class="profileTabs" onclick="showContent('profile')">Profile</a></div>
                <div class="mr4 fw8 info"><a class="profileTabs" onclick="showContent('settings')">Account Settings</a></div>
                <div class="mr4 fw8 info"><a class="profileTabs" onclick="showContent('ratings')">Ratings</a></div>
            </div>
            <div class="flex justify-center">
                <div class="underline"></div>
            </div>
            <div class="flex justify-center">
                <div id="profile" class="content">
                    <div class="info" style="font-size: 1.3rem;" id="userInfo">
                        <p><strong>Name:</strong> <span id="userName"> <%= userName %> </span></p>
                        <p><strong>Email:</strong> <span id="userEmail"> <%= email %>  </span></p>
                        <button onclick="showEditForm()">Edit</button>
                      </div>
                    
                      <div class="info" id="editForm">
                        <form onsubmit="saveUserInfo(); return false;">
                          <label for="editName">Name:</label>
                          <input type="text" id="editName" required>
                          <button type="submit">Save</button>
                          <button type="button" onclick="cancelEdit()">Cancel</button>
                        </form>
                      </div>
                </div>
                
            
                <div id="settings" class="content">
                    <div id="passChange">
                      <p><strong>Email:</strong> <span id="userName"><%= email %> </span></p>
                      <p><strong>Password:</strong> <span id="pass">*******</span></p>
                      <button onclick="showEditSettings()">Edit</button>
                    </div>
                
                    <div id="editForm1">
                      <form onsubmit="saveUserInfo1(); return false;">
                        <label for="editPass">Password:</label>
                        <input type="text" id="editPass" required>
                        <button type="submit">Save</button>
                        <button type="button" onclick="cancelEdit1()">Cancel</button>
                      </form>
                    </div>
                  </div>
            
                <div id="ratings" class="content">
                    <div class="container" style="margin-top: 20px;">
                        <div class="row" style="width: 60rem">
                            <% int review_count = 0; while(rs_review.next()) {%>
                                <div class="col s6 offset-s1">
                                <div class="card">
                                    <div class="card-content">
                                        <span class="card-title"><%= rs_review.getString(3) %></span>
                                            <p><%= rs_review.getString(4) %></p>
                                        </div>
                                        <div class="card-action">
                                            <% if(id != null){ %>
                                                <a onclick=<%= "likeReview(" + rs_review.getInt(1) + ")" %> class="waves-effect waves-teal btn-flat"><i class="material-icons left Small">thumb_up</i><%= rs_review.getInt(5) %> Likes</a>
                                            <a class="waves-effect waves-teal btn-flat modal-trigger" href="#modalComment" review_id=<%= rs_review.getInt(1) %>><i class="material-icons left Small">comment</i>Comment</a>
                                            <div id="modalComment" class="modal">
                                                <div class="modal-content">
                                                    <h1>Write a comment</h1>
                                                    <form id="commentForm">
                                                        <label for="comment">Comment</label>
                                                        <input type="text" id="comment" name="comment" required><br>
                                                        <button type="submit" class="waves-effect waves-light btn">Submit</button>
                                                    </form>
                                                    <div id="response"></div>
                                                </div>
                                                <div class="modal-footer">
                                                    <a href="#!" id="close-button" class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
                                                </div>
                                            </div>
                                            <% } else { %>
                                            <a class="waves-effect waves-teal btn-flat disabled"><i class="material-icons left Small">thumb_up</i><%= rs_review.getInt(5) %> Likes</a>
                                            <a class="waves-effect waves-teal btn-flat disabled"><i class="material-icons left Small">comment</i>Comment</a>
                                            <% } %>
            
                                        </div>
                                        <ul class="collection with-header" style="border:none">
                                            <li class="collection-header center-align">COMMENTS</li>
                                            <%
                                                PreparedStatement stmt_comment = con.prepareStatement("SELECT name, message FROM comment INNER JOIN user ON comment.user_id = user.user_id WHERE review_id = ?");
                                                stmt_comment.setInt(1, rs_review.getInt(1));
                                                ResultSet rsComment = stmt_comment.executeQuery();
            
                                                while (rsComment.next()) {
                                            %>
                                                <li class="collection-item"><a class="blue-text"><%= rsComment.getString("name") %></a> - <%= rsComment.getString("message") %></li>
                                            <%
                                               }
                                               rsComment.close();
                                               stmt_comment.close();
                                            %>
                                        </ul>
                                </div>
                                </div>
            
                            <% review_count++; } %>
                            <% if(review_count == 0) {%>
                                <h3 class="center-align">No Reviews...</h3>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
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
            // Initially hide the editForm1
            document.getElementById("editForm1").style.display = "none";
        
            function showEditForm() {
              // Hide user info and show edit form
              document.getElementById("userInfo").style.display = "none";
              document.getElementById("editForm").style.display = "block";
            
        
              // Populate edit form with current user info
              document.getElementById("editName").value = document.getElementById("userName").innerText;
              document.getElementById("editEmail").value = document.getElementById("userEmail").innerText;
            }
            
            function showEditSettings() {
                  // Hide passChange and show editForm1
                  document.getElementById("passChange").style.display = "none";
                  document.getElementById("editForm1").style.display = "block";
            
                  // Populate edit form with current user info
                  document.getElementById("editPass").value = document.getElementById("pass").innerText;
                }
        
            function cancelEdit() {
              // Show user info and hide edit form
              document.getElementById("userInfo").style.display = "block";
              document.getElementById("editForm").style.display = "none";
            }
            
            function cancelEdit1() {
                  // Show passChange and hide editForm1
                  document.getElementById("passChange").style.display = "block";
                  document.getElementById("editForm1").style.display = "none";
            }
        
            function saveUserInfo() {
              // Update user info with the values from the edit form
              document.getElementById("userName").innerText = document.getElementById("editName").value;
              document.getElementById("userEmail").innerText = document.getElementById("editEmail").value;
        
              // Show user info and hide edit form
              document.getElementById("userInfo").style.display = "block";
              document.getElementById("editForm").style.display = "none";
            }
            
            function saveUserInfo1() {
                  // Update user info with the values from the edit form
                  document.getElementById("pass").innerText = document.getElementById("editPass").value;
            
                  // Show passChange and hide editForm1
                  document.getElementById("passChange").style.display = "block";
                  document.getElementById("editForm1").style.display = "none";
            }
        </script>
        
        <script>
            function likeReview(review_id) {
                var urlParams = new URLSearchParams(window.location.search);
                const user_id = '${user_id}';

                $.ajax({
                    type: 'POST',
                    url: 'like.jsp',
                    data: {
                        review_id: review_id,
                        user_id: user_id
                    },
                    success: function(response) {
                        location.reload()
                        $('#response').html(response);
                    },
                    error: function() {
                        $('#response').html('An error occurred while submitting the like.');
                    }
                });
            }
        </script>

        <!-- Needed for Modal rate -->
        <script>
            $(document).ready(function() {
                $('#modal').modal({
                    onOpenEnd: function() {
                        initializeRatingSystem();
                    }
                });

                $('#agree-button').on('click', function() {
                    const urlParams = new URLSearchParams(document.location.search);
                    const club_id = urlParams.get('id');
                    const selectedRating = document.getElementById("selected-rating").value;
                    const user_id = '${user_id}';

                    // Send the rating to the server using an AJAX request
                    $.ajax({
                        type: "POST",
                        url: "update_rate.jsp", // JSP file to handle the database insertion
                        data: {
                            club_id: club_id,
                            user_id: user_id,
                            rating: selectedRating
                        },
                        success: function(data) {
                            console.log("Rating sent to the server.");
                            location.reload()
                            // You can handle the response from the server here if needed
                        },
                        error: function() {
                            console.error("Failed to send rating.");
                        }
                    });
                });
            });
            
            function initializeRatingSystem() {
                const stars = document.querySelectorAll("#modal .star");
                const selectedRating = document.getElementById("selected-rating");
            
                stars.forEach(star => {
                    star.addEventListener("mouseover", () => {
                        
                    });
            
                    star.addEventListener("click", () => {
                        const rating = parseInt(star.getAttribute("data-rating"));
                        selectedRating.value = rating;
            
                        // Toggle the 'filled' class for all stars based on the selected rating
                        stars.forEach(starItem => {
                            const starRating = parseInt(starItem.getAttribute("data-rating"));
                            if (starRating <= rating) {
                                starItem.classList.add("filled");
                            } else {
                                starItem.classList.remove("filled");
                            }
                        });
                    });
                });
            
                // Clear the rating when the mouse leaves the star container
                document.getElementById("star-rating").addEventListener("mouseleave", () => {
                    const rating = parseInt(selectedRating.value);
                    stars.forEach(starItem => {
                        const starRating = parseInt(starItem.getAttribute("data-rating"));
                        if (starRating <= rating) {
                            starItem.classList.add("filled");
                        } else {
                            starItem.classList.remove("filled");
                        }
                    });
                });
            }
            </script>
            <!-- Needed for Modal Write review -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
            
            <script>
                $(document).ready(function() {
                $('#modalReview').modal();

                $('#reviewForm').submit(function(e) {
                    e.preventDefault();

                    var title = $('#title').val();
                    var review = $('#review').val();
                    var urlParams = new URLSearchParams(window.location.search); // Create URLSearchParams
                    var club_id = urlParams.get('id'); // Extract 'id' from the URL
                    const user_id = '${user_id}';

                    $.ajax({
                        type: 'POST',
                        url: 'processReview.jsp',
                        data: {
                            title: title,
                            review: review,
                            club_id: club_id, // Include club_id in the data
                            user_id: user_id
                        },
                        success: function(response) {
                            location.reload()
                            $('#response').html(response);
                        },
                        error: function() {
                            $('#response').html('An error occurred while submitting the review.');
                        }
                    });
                });

                // Add an event listener to the "Close" button
                $('#close-button').click(function() {
                    location.reload(); // Reload the page
                });
            });
            </script>

            <!-- Needed for comments -->
            <script>
                $(document).ready(function() {
                $('#modalComment').modal();

                var review_id = 0;
                $('#modalComment').modal({
                    onOpenStart: function(modal, trigger) {
                        review_id = $(trigger).attr('review_id');
                    }
                });

                $('#commentForm').submit(function(e) {
                    e.preventDefault();

                    var comment = $('#comment').val();
                    var urlParams = new URLSearchParams(window.location.search);
                    const user_id = '${user_id}';

                    $.ajax({
                        type: 'POST',
                        url: 'comment.jsp',
                        data: {
                            comment: comment,
                            review_id: review_id,
                            user_id: user_id
                        },
                        success: function(response) {
                            location.reload()
                            $('#response').html(response);
                        },
                        error: function() {
                            $('#response').html('An error occurred while submitting the review.');
                        }
                    });
                });

                // Add an event listener to the "Close" button
                $('#close-button').click(function() {
                    location.reload(); // Reload the page
                });
            });

            </script>

            <!-- Events script-->
            <script>
                $(document).ready(function() {
                $('#events').modal();
            });
            </script>
        
            
    </body>
</html>
