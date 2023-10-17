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
        int rate_value = Integer.parseInt(request.getParameter("rating"));
        
        int id = 0;
        
        Class.forName("com.mysql.jdbc.Driver");
        
        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";
    
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
            String updateQuery = "UPDATE rate SET rating = rating + ? WHERE user_id = ?";
            try (PreparedStatement preparedStatement = conn.prepareStatement(updateQuery)) {
                preparedStatement.setInt(1, rate_value);
                preparedStatement.setInt(2, id);
    
                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("Rating updated successfully");
                } else {
                    out.println("Failed to update rating");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        out.println("Invalid rating value");
    }
    %>    
    


</body>
</html>
