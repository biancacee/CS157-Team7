<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Mod</title>
</head>
<body>
    <%
        try {
            String user_id = request.getParameter("user_id");
            String club_id = request.getParameter("club_id");

            Class.forName("com.mysql.jdbc.Driver");

            String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
            String dbUser = "root";
            String dbPassword = "root";

            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                String updateQuery = "DELETE FROM moderates WHERE user_id = ? AND club_id = ?;";
                try (PreparedStatement preparedStatement = conn.prepareStatement(updateQuery)) {
                    // Convert user_id and club_id to integers
                    int userIdInt = Integer.parseInt(user_id);
                    int clubIdInt = Integer.parseInt(club_id);

                    preparedStatement.setInt(1, userIdInt);
                    preparedStatement.setInt(2, clubIdInt);

                    int rowsAffected = preparedStatement.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("Deleted successfully");
                    } else {
                        out.println("Failed to delete");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.println("Invalid");
        }
    %>    
</body>
</html>
