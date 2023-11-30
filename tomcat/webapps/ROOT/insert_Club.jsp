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
    PreparedStatement preparedStatement = null;

    try {
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

            String sql = "INSERT INTO club (name, logo, contact_email, discord_link, instagram_link, description, membership_fee) VALUES (?, ?, ?, ?, ?, ?, ?)";

            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, clubName);
            preparedStatement.setString(2, "http://localhost:8080/images/" + newFileName); // Use setBinaryStream for handling file uploads
            preparedStatement.setString(3, clubEmail);
            preparedStatement.setString(4, discordLink);
            preparedStatement.setString(5, instagramLink);
            preparedStatement.setString(6, clubDescription);
            preparedStatement.setString(7, memberFee);

            // Execute the query
            preparedStatement.execute();
            
            // Optionally, redirect the user to a success page
            response.sendRedirect("index.jsp");
        } else {
            // Handle the case when filePart is null
            // You may want to display an error message or take appropriate action
            response.sendRedirect("error.jsp");
        }

    }
     finally {
        // Close resources in a finally block
        try {
            if (preparedStatement != null) preparedStatement.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
    %>
</body>
</html>
