<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Rating</title>
</head>
<body>
    <%
            String user_id = request.getParameter("user_id");
            String club_id = request.getParameter("club_id");
            String comment = request.getParameter("comment");
        try
        {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", "root", "root");

            PreparedStatement ps = con.prepareStatement("INSERT INTO comment(user_id, review_id, message) VALUES (?, ?, ?)");

            ps.setString(1, user_id);
            ps.setString(2, club_id);
            ps.setString(3, comment);

            int x = ps.executeUpdate();
            
            ps.close();
            con.close();
        }
        catch (SQLException e)
        {
                if(e.getMessage().equals("Column 'message' cannot be null"))
                {
                    out.println("Please enter comment");
                }
                else
                {
                    out.println("Error: " + e.getMessage());
                    e.printStackTrace();
                }
        }
    %> 
</body>
</html>