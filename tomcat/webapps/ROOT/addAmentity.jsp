<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.mysql.jdbc.Driver" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Amentity</title>
</head>
<body>
    <%
    try {
        int event_id = Integer.parseInt(request.getParameter("event_id"));
        int amentity_id = Integer.parseInt(request.getParameter("amentity_id"));

        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.jdbc.Driver");
        
        String insertQuery = "INSERT INTO event_includes VALUES(?, ?)";

        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            PreparedStatement preparedStatement = conn.prepareStatement(insertQuery)) {

            preparedStatement.setInt(1, event_id);
            preparedStatement.setInt(2, amentity_id);

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
        out.println("Invalid value");
    }
    %>
</body>
</html>
