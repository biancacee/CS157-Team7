<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Pass</title>
</head>
<body>
    <% 
        int user_id = -1;
        if(session.getAttribute("user_id") != null)
            user_id = (int)session.getAttribute("user_id");
            %>
    <%
    try {
        String newPassword = request.getParameter("newPassword");
        
        Class.forName("com.mysql.jdbc.Driver");
        
        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";
    
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) 
        {
            String updateQuery = "UPDATE user SET password = ? WHERE user_id = ?;";
            try (PreparedStatement preparedStatement = conn.prepareStatement(updateQuery)) 
            {
                preparedStatement.setString(1, newPassword);
                preparedStatement.setInt(2, user_id);

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
