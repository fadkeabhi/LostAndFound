<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBUtil" %>

<%
// Check if the form was submitted
if (request.getMethod().equals("POST")) {
    String itemName = request.getParameter("itemName");
    String description = request.getParameter("description");
    String question = request.getParameter("question");
    String itemType = request.getParameter("itemType");
    
    // Get the username of the currently logged-in user (assuming you have a session attribute set for the username)
    String postedBy = (String) session.getAttribute("loggedInUserId");

    try {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO items (item_name, description, question, item_type, posted_by) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, itemName);
        pstmt.setString(2, description);
        pstmt.setString(3, question);
        pstmt.setString(4, itemType);
        pstmt.setString(5, postedBy);
        pstmt.executeUpdate();
        
     	// Retrieve the generated keys
        ResultSet rs = pstmt.getGeneratedKeys();
        int itemId = 0;
        if (rs.next()) {
            itemId = rs.getInt(1);
            // out.print(itemId);
        }
        rs.close();
        conn.close();
        
        response.sendRedirect("item.jsp?id=" + itemId);
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>
