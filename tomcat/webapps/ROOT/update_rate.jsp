<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Rating</title>
</head>
<body>
    <%
    try {
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        int club_id = Integer.parseInt(request.getParameter("club_id"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        
        Class.forName("com.mysql.jdbc.Driver");
        
        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";
    
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) 
        {
            String updateQuery = "INSERT INTO rate VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE rating = ?";
            try (PreparedStatement preparedStatement = conn.prepareStatement(updateQuery)) 
            {
                preparedStatement.setInt(1, user_id);
                preparedStatement.setInt(2, club_id);
                preparedStatement.setInt(3, rating);
                preparedStatement.setInt(4, rating);

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) 
                {
                    out.println("Rating updated successfully");
                } 
                else 
                {
                    out.println("Failed to update rating");
                }
            }
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    } 
    catch (NumberFormatException e) 
    {
        e.printStackTrace();
        out.println("Invalid rating value");
    }
    %>    
    


</body>
</html>
