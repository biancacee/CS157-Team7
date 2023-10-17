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
                <li><a href="log-in">Log In</a></li>
                <li><a href="sign-up">Sign Up</a></li>
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
                                            <span class="star" data-rating="1"></span>
                                            <span class="star" data-rating="2"></span>
                                            <span class="star" data-rating="3"></span>
                                            <span class="star" data-rating="4"></span>
                                            <span class="star" data-rating="5"></span>
                                        </div>
                                        
                                    </p>
                                </div>
                                <div class="modal-footer">
                                    <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Agree</a>
                                </div>
                            </div>
                            <div class="col left-align"><a href=<%= "review.jsp?club_id=" + id%> style="background-color:#687494" class="waves-effect waves-light btn"><i class="material-icons left">border_color</i>Write Review</a></div>
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
        <!-- Needed for Modal review -->
        <script>
            const stars = document.querySelectorAll(".star");
        
            stars.forEach(star => {
                star.addEventListener("mouseenter", () => {
                    const rating = parseInt(star.getAttribute("data-rating"));
                    stars.forEach(s => {
                        const sRating = parseInt(s.getAttribute("data-rating"));
                        if (sRating <= rating) {
                            s.classList.add("filled");
                        } else {
                            s.classList.remove("filled");
                        }
                    });
                });
        
                star.addEventListener("mouseleave", () => {
                    // Clear all stars when the mouse leaves the rating area
                    stars.forEach(s => {
                        s.classList.remove("filled");
                    });
                });
        
                star.addEventListener("click", () => {
                    // Set the rating when a star is clicked
                    const rating = parseInt(star.getAttribute("data-rating"));
                    // Perform any additional action on clicking if needed
                });
            });
        </script>
        <!-- Needed for Modal -->
        <script>
            $(document).ready(function(){
            $('#modal').modal();
            });
        </script>
    </body>
</html>