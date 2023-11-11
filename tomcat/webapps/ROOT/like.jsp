<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Rating</title>
</head>
<body>
    <%
    try {
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        int review_id = Integer.parseInt(request.getParameter("review_id"));
        
        Class.forName("com.mysql.jdbc.Driver");
        
        String dbUrl = "jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPassword = "root";
    
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) 
        {
            boolean doesLikeExist = true;
            String queryCheck = "SELECT COUNT(*) FROM `like` WHERE user_id = ? AND review_id = ?";
            try(PreparedStatement preparedStatement = conn.prepareStatement(queryCheck))
            {
              int count = 0;
              preparedStatement.setInt(1, user_id);
              preparedStatement.setInt(2, review_id);
              ResultSet rs = preparedStatement.executeQuery();
              rs.next();
              count = rs.getInt(1);
              if(count == 0)
                doesLikeExist = false;

              preparedStatement.close();
              rs.close();
            }

            if(!doesLikeExist)
            {
              String query = "INSERT INTO `like` VALUES (?, ?)";
              try (PreparedStatement preparedStatement = conn.prepareStatement(query)) 
              {
                preparedStatement.setInt(1, user_id);
                preparedStatement.setInt(2, review_id);

                preparedStatement.executeUpdate();
                preparedStatement.close();
              }
            }
            else
            {
              String query = "DELETE FROM `like` WHERE user_id = ? AND review_id = ?";
              try (PreparedStatement preparedStatement = conn.prepareStatement(query)) 
              {
                preparedStatement.setInt(1, user_id);
                preparedStatement.setInt(2, review_id);

                preparedStatement.executeUpdate();
                preparedStatement.close();
              }
            }
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    } 
    catch (NumberFormatException e) 
    {
        e.printStackTrace();
        out.println("Invalid rating value");
    }
    %>    
</body>
</html>
