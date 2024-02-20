<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Define database connection parameters
    String url = "jdbc:mysql://localhost:3306/clipboard1";
    String username = "root";
    String password = "";

    // Initialize the database connection
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Create a connection to the database
        conn = DriverManager.getConnection(url, username, password);

        // Create a statement for executing SQL queries
        stmt = conn.createStatement();

        // Execute a select query
        String sql = "SELECT * FROM clips";
        rs = stmt.executeQuery(sql);

        // Display the results
        out.println("<h2>Results:</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>Clip</th></tr>");
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("id") + "</td>");
            out.println("<td>" + rs.getString("created_at") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close the database resources
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
