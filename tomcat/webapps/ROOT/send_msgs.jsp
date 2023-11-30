<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    int user_id = -1;
    if(session.getAttribute("user_id") != null)
        user_id = (int)session.getAttribute("user_id");
%>
<%
    String userEmail = request.getParameter("email_inline");
    String message = request.getParameter("message");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");
        String getEmail = "SELECT user_id FROM user WHERE sjsu_email = ?";
        try (PreparedStatement userid_ps = con.prepareStatement(getEmail))
        {
            userid_ps.setString(1, userEmail);
            ResultSet userid_Result = userid_ps.executeQuery();

            int recipient_userid;
            if (userid_Result.next())
            {
                recipient_userid = userid_Result.getInt("user_id");

                String insertMessage = "INSERT INTO private_message (sender_id, receiver_id, message, time_stamp) VALUES (?, ?, ?, current_timestamp)";
                try (PreparedStatement insertMessageStatement = con.prepareStatement(insertMessage))
                {
                    int senderUserId = (int) session.getAttribute("user_id");
                    insertMessageStatement.setInt(1, senderUserId);
                    insertMessageStatement.setInt(2, recipient_userid);
                    insertMessageStatement.setString(3, message);

                    int rowsAffected = insertMessageStatement.executeUpdate();

                    if (rowsAffected > 0)
                    {
                        request.getRequestDispatcher("messages.jsp").forward(request, response);
                        return;
                    } else
                    {
                        out.println("<script>alert('Failed to send the message.');</script>");
                    }
                }
            }
            else
            {
                out.println("<script>alert('User not found with the provided email.');</script>");
            }
        }
        }
    catch (SQLException | ClassNotFoundException e)
        {
            out.println("<script>alert('Exception caught: " + e.getMessage() + "');</script>");
        }
        %>