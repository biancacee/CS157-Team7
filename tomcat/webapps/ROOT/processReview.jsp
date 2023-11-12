<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.mysql.jdbc.Driver" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Review</title>
</head>
<body>
    <%
    try {
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        int club_id = Integer.parseInt(request.getParameter("club_id"));

        String title = request.getParameter("title");
        String review = request.getParameter("review");

        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.jdbc.Driver");
        
        String insertQuery = "INSERT INTO review (user_id, club_id, title, description) VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement preparedStatement = conn.prepareStatement(insertQuery)) {

            preparedStatement.setInt(1, user_id);
            preparedStatement.setInt(2, club_id);
            preparedStatement.setString(3, title);
            preparedStatement.setString(4, review);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                out.println("Review successfully.");
            } else {
                out.println("Failed to insert review data.");
            }
        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace(); // Log the stack trace for more information
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        out.println("Invalid review value");
    }
    %>
</body>
</html>
