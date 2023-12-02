<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, java.nio.file.*, java.io.InputStream, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException, java.io.InputStream, java.nio.file.Files, java.nio.file.Path, java.nio.file.StandardCopyOption" %>


<!DOCTYPE html>
<html>
<head>
    <title>Insert Club</title>
</head>
<body>
    <%
    Connection conn = null;
    PreparedStatement clubStatement = null;
    PreparedStatement userStatement = null;

    try {
        int user_id = -1;
            if(session.getAttribute("user_id") != null)
            {
                user_id = (int)session.getAttribute("user_id");
            }
        // Register the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a database connection
        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";    

        // Retrieve form data from the request
        String clubName = request.getParameter("clubName");
        String clubDescription = request.getParameter("clubDescription");
        String discordLink = request.getParameter("discordLink");
        String instagramLink = request.getParameter("instagramLink");
        String memberFee = request.getParameter("memberFee");
        String clubEmail = request.getParameter("clubEmail");

        // Handle file upload
        Part filePart = request.getPart("clubPicture");

        // Check if filePart is not null before proceeding
        if (filePart != null) {
            InputStream fileContent = filePart.getInputStream();
            String newFileName = UUID.randomUUID() + filePart.getSubmittedFileName();
            Files.copy(fileContent, (Path)Paths.get("..", "webapps", "ROOT", "images", newFileName), StandardCopyOption.REPLACE_EXISTING);
            
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Insert into the club table
            String clubSql = "INSERT INTO club (name, logo, contact_email, discord_link, instagram_link, description, membership_fee) VALUES (?, ?, ?, ?, ?, ?, ?)";

            // Specify that you want to retrieve generated keys
            clubStatement = conn.prepareStatement(clubSql, Statement.RETURN_GENERATED_KEYS);
            clubStatement.setString(1, clubName);
            clubStatement.setString(2, "http://localhost:8080/images/" + newFileName);
            clubStatement.setString(3, clubEmail);
            clubStatement.setString(4, discordLink);
            clubStatement.setString(5, instagramLink);
            clubStatement.setString(6, clubDescription);
            clubStatement.setString(7, memberFee);

            // Execute the club insertion query
            clubStatement.execute();

            // Retrieve the generated keys (including club_id)
            ResultSet generatedKeys = clubStatement.getGeneratedKeys();

            int lastInsertedClubId;

            // Check if a key was generated
            if (generatedKeys.next()) {
                lastInsertedClubId = generatedKeys.getInt(1);
                // Now, you have the last inserted club_id
                out.println("Last Inserted Club ID: " + lastInsertedClubId);
            } else {
                // Handle the case when no key was generated
                out.println("No Club ID generated");
                response.sendRedirect("error.jsp");
                return;
            }

            // Insert into the moderates table
            String moderatesSql = "INSERT INTO moderates (user_id, club_id) VALUES (?, ?)";
            userStatement = conn.prepareStatement(moderatesSql);
            userStatement.setInt(1, user_id); // Assuming you have user_id available
            userStatement.setInt(2, lastInsertedClubId);

            // Execute the moderates insertion query
            userStatement.execute();

            // Optionally, redirect the user to a success page
            response.sendRedirect("index.jsp");

        } else {
            // Handle the case when filePart is null
            // You may want to display an error message or take appropriate action
            response.sendRedirect("error.jsp");
        }

    } finally {
        // Close resources in a finally block
        try {
            if (clubStatement != null) clubStatement.close();
            if (userStatement != null) userStatement.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>


</body>
</html>
