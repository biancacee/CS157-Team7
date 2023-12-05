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
            <h2 class="flex justify-center">Edit Clubs and Add Moderator </h2>
            <div id="Moderator" class="container pt3">
                <!-- List of clubs -->
                <ul class="collection with-header">
                <%
                    try 
                    {
                        int user_id = -1;
                        if(session.getAttribute("user_id") != null)
                        {
                            user_id = (int)session.getAttribute("user_id");
                        }
                        String club_name = request.getParameter("club-name");
    
                        java.sql.Connection connect;
                        Class.forName("com.mysql.jdbc.Driver");
                        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");
    
                        PreparedStatement list = connect.prepareStatement("SELECT club_id, name, logo FROM moderates NATURAL JOIN club WHERE club.club_id = moderates.club_id AND user_id = ?;");
                        list.setInt(1, user_id);
                        ResultSet sr = list.executeQuery();
                        
                        while(sr.next()) {
                        int clubId = sr.getInt(1);

                        PreparedStatement list1 = connect.prepareStatement("SELECT name, description, contact_email, discord_link, instagram_link, membership_fee, is_active FROM club WHERE club_id = ?;");
                        list1.setInt(1, clubId);
                        ResultSet sr1 = list1.executeQuery();
                        
                        if (sr1.next()) { // Check if there are results
                            String name = sr1.getString(1);
                            String description = sr1.getString(2);
                            String contact_email = sr1.getString(3);
                            String discord_link = sr1.getString(4);
                            String instagram_link = sr1.getString(5);
                            int membership_fee = sr1.getInt(6);
                            int isActive = sr1.getInt(7);
                        
                    {
                %>
                    <li class="collection-item avatar">
                        <img src=<%= sr.getString(3) %> alt="" class="circle">
                        <a href=<%= "club.jsp?id=" + sr.getInt(1) %> class="title"><%= sr.getString(2) %></a>
                        <div class="add_Mod">
                            <a class="waves-effect waves-light modal-trigger secondary-content pr4 mr3" href="#modal_<%= clubId %>">
                                <i class="material-icons">add_circle_outline</i>
                            </a>
                            <div id="modal_<%= clubId %>" class="modal">
                                <div class="modal-content">
                                    <h5>Enter Students Email to add as Moderator</h5>
                                    <form id="updateForm" class="col s12" method="post" action="mod_email_update.jsp" onsubmit="return validateForm()">
                                        <div class="row">
                                            <input id="srValue" type="hidden" name="srValue" value="<%= clubId %>" >
                                            <div class="input-field col s12">
                                                <input id="sjsu_email"  name="sjsu_email" type="email" class="validate" required>
                                                <label for="sjsu_email">SJSU Email</label>
                                                <div id="emailError" class="red-text"></div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <button class="btn btn-primary btn-sm" type="submit">Submit
                                                <i class="material-icons right">send</i>
                                            </button>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat">Close</a>
                                </div>
                            </div>
                        </div>
                        
                          
                        <div class="edit_club">
                            <a class="waves-effect waves-light modal-trigger secondary-content" href="#modal1_<%= clubId %>">
                                <i class="material-icons">edit</i>
                            </a>
                            <div id="modal1_<%= clubId %>" class="modal">
                                <div class="modal-content flex flex-column justify-center">
                                    <div><h5>Edit Club Information</h5></div>
                                    <div class="">
                                        <form class="col s12" id="updateFormOne" method="post" action="updateClub.jsp">
                                            <div class="row">
                                                <input type="hidden" id="srValue1" name="srValue1" value="<%= clubId %>">
                                                <div class="input-field col s6">
                                                    <input id="clubName" onclick="clearInputValue(this);" value="<%= name %>" name="clubName" type="text" class="validate" required>
                                                    <div id="nameError" class="red-text"></div>
                                                    
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input id="clubDescription" onclick="clearInputValue(this);" value="<%= description %>" name="clubDescription" type="text" class="validate" required>
                                                    <label for="clubDescription">Club Description</label>
                                                    <div id="descError" class="red-text"></div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input id="clubEmail" onclick="clearInputValue(this);" value="<%= contact_email %>" name="clubEmail" type="text" class="validate" required>
                                                    <label for="clubEmail">Club Email</label>
                                                    <div id="emailError1" class="red-text"></div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input id="discordLink" onclick="clearInputValue(this);" value="<%= discord_link %>" name="discordLink" type="text" class="validate" required>
                                                    <label for="discordLink">discord Link</label>
                                                    <div id="linkError" class="red-text"></div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input id="instagramLink" onclick="clearInputValue(this);" value="<%= instagram_link %>" name="instagramLink" type="text" class="validate" required>
                                                    <label for="instagramLink">Instagram Link</label>
                                                    <div id="linkError1" class="red-text"></div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input id="memberFee" onclick="clearInputValue(this);" value="<%= membership_fee %>" name="memberFee" type="text" class="validate" required>
                                                    <label for="memberFee">Member Fee</label>
                                                    <div id="feeError" class="red-text"></div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <% if(isActive == 1) { %>
                                                    <p>
                                                        <label>
                                                            <input id="checkbox" type="checkbox" value="0" name="isActive"/>
                                                            <span>Deactivate Club</span>
                                                            <input type="hidden" name="isActive" value="<%= isActive %>">
                                                        </label>
                                                    </p>
                                                    <% } else{ %>
                                                    <p>
                                                        <label>
                                                            <input id="checkbox"  type="checkbox" value="1" name="isActive" />
                                                            <span>Activate Club</span>
                                                            <input type="hidden" name="isActive" value="<%= isActive %>">
                                                        </label>
                                                    </p>
                                                    
                                                    <% } %>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <button class="btn btn-primary btn-sm" type="submit">Submit
                                                    <i class="material-icons right">send</i>
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat">close</a>
                                </div>
                            </div>
                        </div>
                        <%
                        }
                        }%>  
                    </li>
                <%
                    }
                        
                        sr.close();
                        list.close();
                        connect.close();
                    }
                    catch(SQLException e) 
                    {
                        out.println("SQLException caught: " + e.getMessage());
                        e.printStackTrace();
                    }
                %>
                </ul>
            </div>
            
        </div>
        <script>
            $(document).ready(function(){
                $('.modal').modal();
            });

            function clearInputValue(input) {
                input.value = "";
            }

            function submitForm() {
                var isForm1Valid = validateForm();
                var isForm2Valid = validateForm1();

                if (isForm1Valid) {
                    document.getElementById("updateForm").submit();
                }

                if (isForm2Valid) {
                    document.getElementById("updateFormOne").submit();
                }
            }
            
        </script>
    </body>
</html>
