<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBUtil" %>

<%
// Check if the form was submitted
if (request.getMethod().equals("POST")) {
    int itemId = Integer.parseInt(request.getParameter("itemId"));
    String itemName = request.getParameter("itemName");
    String description = request.getParameter("description");
    String question = request.getParameter("question");
    String itemType = request.getParameter("itemType");
    
    try {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE items SET item_name=?, description=?, question=? WHERE item_id=? AND posted_by = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, itemName);
        pstmt.setString(2, description);
        pstmt.setString(3, question);
        pstmt.setInt(4, itemId);
        pstmt.setInt(5, Integer.parseInt(session.getAttribute("loggedInUserId").toString()));
        pstmt.executeUpdate();
        
        conn.close();
        
        response.sendRedirect("item.jsp?id=" + itemId);
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>
