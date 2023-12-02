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
    PreparedStatement stmt = null;

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
        String redirectPth = request.getParameter("redirectPth");
        String amentityName = request.getParameter("name");
        String amentityDescription = request.getParameter("description");

        // Handle file upload
        Part filePart = request.getPart("picture");

        // Check if filePart is not null before proceeding
        if (filePart != null) 
        {
            InputStream fileContent = filePart.getInputStream();
            String newFileName = UUID.randomUUID() + filePart.getSubmittedFileName();
            Files.copy(fileContent, (Path)Paths.get("..", "webapps", "ROOT", "images", newFileName), StandardCopyOption.REPLACE_EXISTING);
            
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            String sql = "INSERT INTO amentities (image, name, description) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE image=?, name=?, description=?";

            // Specify that you want to retrieve generated keys
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "http://localhost:8080/images/" + newFileName);
            stmt.setString(2, amentityName);
            stmt.setString(3, amentityDescription);
            stmt.setString(4, "http://localhost:8080/images/" + newFileName);
            stmt.setString(5, amentityName);
            stmt.setString(6, amentityDescription);

            // Execute the club insertion query
            stmt.execute();
            response.sendRedirect(redirectPth);
        } 
        else 
        {
            // Handle the case when filePart is null
            // You may want to display an error message or take appropriate action
            response.sendRedirect("error.jsp");
        }

    } finally {
        // Close resources in a finally block
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>


</body>
</html>
