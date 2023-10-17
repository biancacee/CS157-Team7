<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Rating</title>
</head>
<body>
  <%
int rating = Integer.parseInt(request.getParameter("rating"));

// You can retrieve user_id as needed
String user_id = "user_id"; // Change to the actual user_id

java.sql.Connection conn = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

    String updateQuery = "INSERT INTO rate (user_id, rating) VALUES (?, ?)";
    PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
    preparedStatement.setString(1, user_id);
    preparedStatement.setInt(2, rating);

    int rowsAffected = preparedStatement.executeUpdate();
    if (rowsAffected > 0) {
        out.println("Rating updated successfully");
    } else {
        out.println("Failed to update rating");
    }
} catch (Exception e) {
    e.printStackTrace();
    out.println("Error: " + e.getMessage());
} finally {
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>


</body>
</html>
