<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="db.DBUtil" %>

<link rel="stylesheet" href="test.css">

<%

// Initialize the database connection
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
try {
    conn = DBUtil.getConnection();
    // Use the connection for your database operations
} catch (SQLException e) {
    // Handle any SQL exceptions
	out.println("Error: " + e.getMessage());
} finally {
    if (conn != null) {
        try {
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
            
            conn.close();
        } catch (SQLException e) {
            // Handle any SQL exceptions
        	out.println("Error: " + e.getMessage());
        }
    }
}
%>
