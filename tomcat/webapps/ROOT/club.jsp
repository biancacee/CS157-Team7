<%@ page import="java.sql.*"%>
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
                <li><a href="login.jsp">Log In</a></li>
                <li><a href="signup.jsp">Sign Up</a></li>
              </ul>
            </div>
        </nav>

        <!-- Get Club -->
        <%
        try 
        {
            String id = request.getParameter("id");

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

            PreparedStatement stmt_review = con.prepareStatement("SELECT review_id, user_id, title, description FROM review WHERE club_id = ?");
            stmt_review.setString(1, id);
            ResultSet rs_review = stmt_review.executeQuery();
        %>

        <!-- Club -->
        <div style="background-color:#e9ecee">
            <div class="container center-align" style="padding: 15px;">
                <h4><%= rs.getString(2) %></h4>

                <div class="row">
                    <div class="col s7 push-s5 left-align" style="padding: 15px; padding-left: 20px;">
                        <% if(avg_rating != 0) { %>
                            <div><b>Rating: </b><%= avg_rating %></div>
                        <% } else { %> 
                            <div><b>Rating: </b>No Rating</div>
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
                        <p><%= rs.getString(7) %></p>
                        <hr />
                        <div class="row">
                            <!-- Modal Trigger -->
                            <a class="waves-effect waves-light btn modal-trigger" style="background-color:#687494" href="#modal"><i class="material-icons left">offline_pin</i>Rate</a>

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
                            <a class="waves-effect waves-light btn modal-trigger" style="background-color: #687494" href="#modalReview"><i class="material-icons left">border_color</i>Write Review</a>

                            <!-- Modal Structure -->
                            <div id="modalReview" class="modal">
                                <div class="modal-content">
                                    <h1>Submit a Review</h1>
                                    <form id="reviewForm">
                                        <label for="title">Title:</label>
                                        <input type="text" id="title" name="title" required><br>
                                        <label for="review">Review:</label>
                                        <textarea id="review" name="review" required></textarea><br>
                                        <button type="submit">Submit</button>
                                    </form>
                                    <div id="response"></div>
                                </div>
                                <div class="modal-footer">
                                    <a href="#!" id="close-button" class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
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
                    <div class="col s6 offset-s3">
                    <div class="card">
                        <div class="card-content">
                        <span class="card-title"><%= rs_review.getString(3) %></span>
                        <p><%= rs_review.getString(4) %></p>
                        </div>
                        <div class="card-action">
                        <a href=<%= "like.jsp?club_id=" + id%> class="waves-effect waves-teal btn-flat"><i class="material-icons left Small">thumb_up</i>0 Likes</a>
                        <a href="comment.jsp" class="waves-effect waves-teal btn-flat"><i class="material-icons left Small">comment</i>Comment</a>
                        </div>
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
                    console.log(club_id)
                    const selectedRating = document.getElementById("selected-rating").value;

                    // Send the rating to the server using an AJAX request
                    $.ajax({
                        type: "POST",
                        url: "update_rate.jsp", // JSP file to handle the database insertion
                        data: {
                            club_id: club_id,
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

                    $.ajax({
                        type: 'POST',
                        url: 'processReview.jsp',
                        data: {
                            title: title,
                            review: review,
                            club_id: club_id // Include club_id in the data
                        },
                        success: function(response) {
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
                
            

            
            
            
    </body>
</html>