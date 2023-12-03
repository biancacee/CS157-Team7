<%@ page import="java.sql.*"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
    <head>
        <title>ClubSpartan</title>
    
        <!-- Includes -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link rel="stylesheet" type="text/css" href="style.css">
        <link rel="stylesheet" href="https://unpkg.com/tachyons@4.12.0/css/tachyons.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        

        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
    <body>
        <% 
        int user_id = -1;
        String id = request.getParameter("id");
        boolean isClubMod = false;
        if(session.getAttribute("user_id") != null)
            user_id = (int)session.getAttribute("user_id");
        %>
        <!-- Navbar -->
        <% Connection con1 = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");
            String stmtQueryMod1 = "SELECT club_id FROM moderates WHERE user_id = ?;";
            PreparedStatement isModerator1 = con1.prepareStatement(stmtQueryMod1);
            isModerator1.setInt(1, user_id);
            ResultSet boolMod1 = isModerator1.executeQuery();
            boolean mod = boolMod1.next();

            stmtQueryMod1 = "SELECT * FROM moderates WHERE user_id = ? AND club_id = ?";
            PreparedStatement isModeratorOfClub = con1.prepareStatement(stmtQueryMod1);
            isModeratorOfClub.setInt(1, user_id);
            isModeratorOfClub.setString(2, id);
            ResultSet isClubModResult = isModeratorOfClub.executeQuery();
            isClubMod = isClubModResult.next();
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

                    <% if(mod) {%>
                    <li><a href="moderator.jsp">Manage Clubs</a></li>

                    <% } %>
                    <li><a href="logout.jsp">Logout</a></li>
                <% } %>
                
              </ul>
            </div>
        </nav>
        <% 
        isClubModResult.close();
        isModeratorOfClub.close();
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

        <!-- Get Club -->
        <%
        try 
        {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:"+"3306"+"/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

            PreparedStatement stmt = con.prepareStatement("SELECT * FROM club WHERE club_id = ?");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            rs.next();

            PreparedStatement stmt_rate = con.prepareStatement("SELECT rating FROM rate WHERE club_id = ?");
            stmt_rate.setString(1, id);
            ResultSet rs_rate = stmt_rate.executeQuery();

            int count = 0;
            float avg_rating = 0;
            while(rs_rate.next())
            {
                avg_rating += rs_rate.getInt(1);
                count++;
            }
            if(count > 0)
                avg_rating /= count;

            String stmtQuery = "SELECT r.review_id, r.user_id, r.title, r.description, COUNT(l.user_id) AS like_count FROM review r LEFT JOIN `like` l ON r.review_id = l.review_id WHERE r.club_id = ? GROUP BY r.review_id ORDER BY like_count DESC";
            PreparedStatement stmt_review = con.prepareStatement(stmtQuery);
            stmt_review.setString(1, id);
            ResultSet rs_review = stmt_review.executeQuery();

            PreparedStatement stmt_events = con.prepareStatement("SELECT * FROM event WHERE club_id = ? AND start_date > CURDATE() ORDER BY start_date");
            stmt_events.setString(1, id);
            ResultSet rs_events = stmt_events.executeQuery();

            PreparedStatement stmt_moderators = con.prepareStatement("SELECT u.name AS user_name FROM user u JOIN moderates m ON u.user_id = m.user_id WHERE m.club_id = ?;");
            stmt_moderators.setString(1, id);
                
            PreparedStatement stmt_price = con.prepareStatement("SELECT membership_fee FROM club where club_id = ?;");
            stmt_price.setString(1, id);
            ResultSet rs_price = stmt_price.executeQuery();
            int price = 0;
            while(rs_price.next()){
            price = rs_price.getInt(1);
            }
        %>

        <!-- Club -->
        <div style="background-color:#e9ecee">
            <div class="container center-align" style="padding: 15px;">
                <h4><%= rs.getString(2) %></h4>

                <div class="row">
                    <div class="col s7 push-s5 left-align" style="padding: 15px; padding-left: 20px;">
                        <% if(avg_rating != 0) { %>
                            <div>
                                <span><b>Rating: </b><%= avg_rating %></span>
                                <%if(price != 0){ %>
                                <span class="ml2"><b>Price: </b>$<%= price %></span>
                                <%} else {%>
                                    <span class="ml2"><b>Price: </b>Free</span>
                                    <%}%>
                            </div>
                        <% } else { %> 
                            <div>
                                <span><b>Rating: </b>No Rating</span>
                                <%if(price != 0){ %>
                                <span class="ml2"><b>Price: </b>$<%= price %></span>
                                <%} else {%>
                                    <span class="ml2"><b>Price: </b>Free</span>
                                    <%}%>
                            </div>
                        <% } %>
                        <hr />
                        <b>Contact Email: </b><a href=<%= "mailto: " + rs.getString(4) %>><%= rs.getString(4) %></a><br/>
                        <% 
                            if(rs.getString(6) != null) {
                        %>
                            <b>Instagram Link: </b><a href=<%= rs.getString(6) %>><%= rs.getString(6) %></a><br/>
                        <% } %>
                        <% 
                            if(rs.getString(5) != null) {
                        %>
                            <b>Discord Link: </b><a href=<%= rs.getString(5) %>><%= rs.getString(5) %></a><br/> 
                            
                                
                            
                        <% } %>
                        <hr />
                        <b>Moderators: </b>
                        <% 
                            ResultSet rs_moderators = stmt_moderators.executeQuery();
                            List<String> userNames = new ArrayList<>();
                            
                            while (rs_moderators.next()) {
                                // Retrieve the "user_name" column from the result set
                                String userName = rs_moderators.getString("user_name");
                                
                                // Add the user name to the list
                                userNames.add(userName);
                            }
                        
                            for (int i = 0; i < userNames.size(); i++) {
                                String user = userNames.get(i);
                        %>
                        <span>
                            <%= user %><%= (i < userNames.size() - 1) ? " |" : "" %>
                        </span>
                        <%
                            }
                        %>
                        <hr />
                        <p><%= rs.getString(7) %></p>
                        <hr />
                        <div class="row">
                            <!-- Modal Trigger -->
                            <% if(session.getAttribute("user_id") != null){ %>
                            <a class="waves-effect waves-light btn modal-trigger" style="background-color:#687494" href="#modal"><i class="material-icons left">offline_pin</i>Rate</a>
                            <% } %>
                            <!-- Modal Structure -->
                            <div id="modal" class="modal">
                                <div class="modal-content">
                                    <h4>Rate the Club</h4>
                                    <p style="padding-top:10px">
                                        <div class="rating center-align" id="star-rating">
                                            <div style="font-size: 30px;">Overall experience</div>
                                            <div class="star" data-rating="1"></div>
                                            <div class="star" data-rating="2"></div>
                                            <div class="star" data-rating="3"></div>
                                            <div class="star" data-rating="4"></div>
                                            <div class="star" data-rating="5"></div>
                                        </div>
                                        <!-- Hidden input to store the selected rating -->
                                        <input type="hidden" id="selected-rating" name="selected-rating" value="1">
                                    </p>
                                </div>
                                <div class="modal-footer">
                                    <a id="agree-button" href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Agree</a>
                                </div>
                            </div>

                            <!-- Modal Trigger -->
                            <% if(session.getAttribute("user_id") != null){ %>
                            <a class="waves-effect waves-light btn modal-trigger" style="background-color: #687494" href="#modalReview"><i class="material-icons left">border_color</i>Write Review</a>
                            <% } %>
                            <!-- Modal Structure -->
                            <div id="modalReview" class="modal">
                                <div class="modal-content">
                                    <h1>Submit a Review</h1>
                                    <form id="reviewForm">
                                        <label for="title">Title:</label>
                                        <input type="text" id="title" name="title" required><br>
                                        <label for="review">Review:</label>
                                        <textarea id="review" name="review" required></textarea><br>
                                        <br>
                                        <button type="submit" class="waves-effect waves-light btn">Submit</button>
                                    </form>
                                    <div id="response"></div>
                                </div>
                                <div class="modal-footer">
                                    <a href="#!" id="close-button" class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
                                </div>
                            </div>

                                <!-- Modal Structure -->
                                <div id="modalEvent" class="modal">
                                    <div class="modal-content">
                                        <h1>Add New Event</h1>
                                        <form id="eventForm">
                                            <label for="event_title">Title:</label>
                                            <input type="text" id="event_title" name="event_title" required><br>
                                            <label for="location">Location:</label>
                                            <input type="text" id="location" name="location" required><br>
                                            <label for="start_date">Start Date:</label>
                                            <input type="date" id="start_date" name="start_date" required><br>
                                            <label for="start_time">Start Time:</label>
                                            <input type="time" id="start_time" name="start_time" required><br>
                                            <label for="end_time">End Time:</label>
                                            <input type="time" id="end_time" name="end_time" required><br>
                                            <label for="description">Description:</label>
                                            <textarea id="description" name="description" required></textarea><br>
                                            <br>
                                            <button type="submit" class="waves-effect waves-light btn">Submit</button>
                                        </form>
                                        <div id="response"></div>
                                    </div>
                                    <div class="modal-footer">
                                        <a href="#!" id="close-button" class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
                                    </div>
                                </div>
                            
                            <!-- Modal Trigger -->
                            <a class="waves-effect waves-light btn modal-trigger" style="background-color:#687494" href="#events"><i class="material-icons left">event</i>Events</a>
                            <!-- Modal Structure -->
                            <div id="events" class="modal bottom-sheet">
                                <div class="modal-content">
                                    <h3 class="header">Events</h3>
                                    <% if(isClubMod) { %>
                                        <a class="waves-effect waves-light btn modal-trigger" style="background-color: #687494" href="#modalEvent"><i class="material-icons left">access_time</i>Add Event</a>
                                    <% } %>
                                    <ul class="collection with-header">
                                        <% while(rs_events.next()) { 
                                            if(!isClubMod)
                                            {
                                                %>
                                                <li class="collection-item"><a href=<%= "/event.jsp?event_id=" + rs_events.getInt(1) + "&user_id=" + user_id + "&club_id=" + id %> class="collection-item"><%= rs_events.getString(6) %> : <%= rs_events.getString(4) %> - <%= rs_events.getString(5) %> </a></li>
                                                <%
                                            }
                                            else
                                            {
                                                %>
                                                <li class="collection-item"><div><a href=<%= "/event.jsp?event_id=" + rs_events.getInt(1) + "&user_id=" + user_id + "&club_id=" + id %>><%= rs_events.getString(6) %> : <%= rs_events.getString(4) %> - <%= rs_events.getString(5) %></a><a onclick=<%= "removeEvent(" + rs_events.getInt(1) + ")" %> class="secondary-content"><i class="material-icons">delete</i></a></div></li>
                                                <%
                                            }
                                        } %>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col s5 pull-s7 right-align" style="padding: 15px; padding-right: 20px;">
                        <img style="object-fit: cover; width: 260px; height: 260px;" src=<%= rs.getString(3) %>>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reviews -->
        <div class="container" style="margin-top: 20px;">
            <div class="row">
                <% int review_count = 0; while(rs_review.next()) {%>
                    <div class="col s6">
                    <div class="card">
                        <div class="card-content">
                            <span class="card-title"><%= rs_review.getString(3) %></span>
                                <p><%= rs_review.getString(4) %></p>
                            </div>
                            <div class="card-action">
                                <% if(session.getAttribute("user_id") != null){ %>
                                <a onclick=<%= "likeReview(" + rs_review.getInt(1) + ")" %> class="waves-effect waves-teal btn-flat"><i class="material-icons left Small">thumb_up</i><%= rs_review.getInt(5) %> Likes</a>
                                <a class="waves-effect waves-teal btn-flat modal-trigger" href="#modalComment" review_id=<%= rs_review.getInt(1) %>><i class="material-icons left Small">comment</i>Comment</a>
                                <!-- Modal Comment -->
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
        <%
            rs.close();
            rs_rate.close();
            rs_review.close();
            rs_events.close();
            
            stmt_events.close();
            stmt.close();
            stmt_rate.close();
            stmt_review.close();

            con.close();
        }
        catch(SQLException e) 
        {
            out.println("SQLException caught: " + e.getMessage());
        }
        %>
        <script type="text/javascript" src="js/materialize.min.js"></script>

        <!-- Like Review Event -->
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

            <!-- Need for Events -->
            <script>
                $(document).ready(function() {
                $('#modalEvent').modal();

                $('#eventForm').submit(function(e) {
                    e.preventDefault();

                    var title = $('#event_title').val();
                    var description = $('#description').val();
                    var llocation = $('#location').val();
                    var start_date = $('#start_date').val();
                    var start_time = $('#start_time').val();
                    var end_time = $('#end_time').val();

                    var urlParams = new URLSearchParams(window.location.search);
                    var club_id = urlParams.get('id');

                    $.ajax({
                        type: 'POST',
                        url: 'addEvent.jsp',
                        data: {
                            title: title,
                            description: description,
                            location: llocation,
                            start_date: start_date,
                            start_time: start_time,
                            end_time: end_time,
                            club_id: club_id,
                        },
                        success: function(response) {
                            location.reload()
                            $('#response').html(response);
                        },
                        error: function() {
                            $('#response').html('An error occurred while submitting the event.');
                        }
                    });
                });

                // Add an event listener to the "Close" button
                $('#close-button').click(function() {
                    location.reload(); // Reload the page
                });
            });
            </script>

            <script>
                function removeEvent(id)
                {
                    var urlParams = new URLSearchParams(window.location.search);

                    $.ajax({
                        type: 'POST',
                        url: 'removeEvent.jsp',
                        data: {
                            event_id: id,
                        },
                        success: function(response) {
                            location.reload()
                            $('#response').html(response);
                        },
                        error: function() {
                            $('#response').html('An error occurred while submitting the review.');
                        }
                    });
                }
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

            <!-- Events script -->
            <script>
                $(document).ready(function() {
                $('#events').modal();
            });
            </script>
    </body>
</html>