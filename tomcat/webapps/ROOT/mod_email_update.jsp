<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>

<%
    String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
    ResultSet resultSet = null; // Declare resultSet outside try block

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a connection
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // Get parameters from the request
        String sjsuEmail = request.getParameter("sjsu_email");
        int clubId = 0; // default value

        String srValueParam = request.getParameter("srValue");

        if (srValueParam != null && !srValueParam.isEmpty()) {
            clubId = Integer.parseInt(srValueParam);
        } else {
            // Handle the case where "srValue" is not provided in the request.
            // You might want to redirect or display an error message.
            out.println("The parameter 'srValue' is missing or empty in the request.");
        }

        // Query to get user_id based on sjsu_email
        String sql1 = "SELECT user_id FROM user WHERE sjsu_email = ?";
        pstmt1 = conn.prepareStatement(sql1);
        pstmt1.setString(1, sjsuEmail);

        resultSet = pstmt1.executeQuery(); // Assign the result set here

        if (resultSet.next()) {
            // Retrieve user_id from the ResultSet
            int userId = resultSet.getInt("user_id");

            // Perform the database insert
            String sql = "INSERT INTO moderates (club_id, user_id) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, clubId);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
            response.sendRedirect("index.jsp");
        } else {
            // Handle the case where no user with the specified email was found
            // You might want to redirect or display an error message
            out.println("User not found for the specified email");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        // Close resources in a finally block
        try {
            if (resultSet != null) resultSet.close();
            if (pstmt != null) pstmt.close();
            if (pstmt1 != null) pstmt1.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
