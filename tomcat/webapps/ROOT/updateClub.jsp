<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt1 = null;

    try {
        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";

        // Establish a connection
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String clubId = request.getParameter("srValue1");
        String clubName = request.getParameter("clubName");
        String clubDescription = request.getParameter("clubDescription");
        String clubEmail = request.getParameter("clubEmail");
        String discordLink = request.getParameter("discordLink");
        String instagramLink = request.getParameter("instagramLink");
        String memberFee = request.getParameter("memberFee");

        // Query to update club information
        String sql = "UPDATE club SET name = ?, contact_email = ?, discord_link = ?, instagram_link = ?, description = ?, membership_fee = ? WHERE club_id = ?;";
        pstmt1 = conn.prepareStatement(sql);
        pstmt1.setString(1, clubName);
        pstmt1.setString(2, clubEmail);
        pstmt1.setString(3, discordLink);
        pstmt1.setString(4, instagramLink);
        pstmt1.setString(5, clubDescription);
        pstmt1.setString(6, memberFee);
        pstmt1.setString(7, clubId);

        int rowsAffected = pstmt1.executeUpdate(); // Use executeUpdate for update operations

        response.sendRedirect("club.jsp?id="+clubId);
        
        // Process the result or print the number of rows affected if needed
        out.println("Rows affected: " + rowsAffected);

    } catch (SQLException e) {
        // Handle SQL exceptions
        out.println("Error: " + e.getMessage());
        e.printStackTrace();

    } finally {
        
    }
%>
