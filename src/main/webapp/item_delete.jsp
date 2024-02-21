<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBUtil" %>

<%
// Check if the item ID is provided in the request
if (request.getMethod().equals("POST")) {
    int itemId = Integer.parseInt(request.getParameter("itemId"));
    
    try {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE items SET is_active = 0 WHERE item_id=? AND posted_by = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, itemId);
        pstmt.setInt(2, Integer.parseInt(session.getAttribute("loggedInUserId").toString()));
        pstmt.executeUpdate();
        
        conn.close();
        
        // Redirect to a success page or back to the item list page
        response.sendRedirect("feed.jsp");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
} else {
    // Handle the case where the item ID is not provided
    out.println("<p>Error: Item ID not provided.</p>");
}

%>
