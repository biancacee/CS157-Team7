<%@ page import="java.sql.*"%>
<html>
    <head>
        <title>Three Tier Architecture Demo</title>
    </head>
    <body>
        <h1>JDBC Connection Example</h1>
        <%
        String db = "clubspartan";
        String user = "root";
        String password = "1234";
        try 
        {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubspartan?autoReconnect=true&useSSL=false", user, password);
            out.println(db + " database successfully opened.<br/><br/>");
            con.close();
        }
        catch(SQLException e) 
        {
            out.println("SQLException caught: " + e.getMessage());
        }
        %>
    </body>
</html>