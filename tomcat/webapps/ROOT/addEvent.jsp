<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.mysql.jdbc.Driver" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Event</title>
</head>
<body>
    <%
    try {
        int club_id = Integer.parseInt(request.getParameter("club_id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String start_date = request.getParameter("start_date");
        String start_time = request.getParameter("start_time");
        String end_time = request.getParameter("end_time");

        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.jdbc.Driver");
        
        String insertQuery = "INSERT INTO event (club_id, location, title, description, start_date, start_time, end_time) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            PreparedStatement preparedStatement = conn.prepareStatement(insertQuery)) {

            preparedStatement.setInt(1, club_id);
            preparedStatement.setString(2, location);
            preparedStatement.setString(3, title);
            preparedStatement.setString(4, description);
            preparedStatement.setString(5, start_date);
            preparedStatement.setString(6, start_time);
            preparedStatement.setString(7, end_time);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                out.println("Successful.");
            } else {
                out.println("Failed.");
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
