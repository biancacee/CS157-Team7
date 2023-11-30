<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    int user_id = -1;
    if(session.getAttribute("user_id") != null)
        user_id = (int)session.getAttribute("user_id");
%>
<%
    String message = request.getParameter("message");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        try (
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");
                PreparedStatement ps = con.prepareStatement("insert into private_message(sender_id, receiver_id, message, time_stamp) VALUES (?,21, ?, current_timestamp)")
        ) {
            // Validate user input
            if (message != null && !message.isEmpty()) {
                ps.setInt(1, user_id);
                //ps.setInt(2, user_id);
                ps.setString(2, message);

                int x = ps.executeUpdate();

                if (x > 0) {
                    out.println("Message successfully inserted.");
                } else {
                    out.println("Message insertion failed.");
                }
            } else {
                out.println("Please enter a message.");
            }
        } catch (SQLException e) {
            // Log the exception to a log file or another appropriate location
            out.println("Error: An unexpected error occurred.");
            e.printStackTrace();
        }
    } catch (ClassNotFoundException e) {
        out.println("Error: JDBC Driver not found.");
        e.printStackTrace();
    }
%>