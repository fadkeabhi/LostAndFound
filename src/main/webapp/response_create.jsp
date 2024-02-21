<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBUtil" %>

<%
// Check if the form was submitted
if (request.getMethod().equals("POST")) {
    String responseText = request.getParameter("ressponse_text");
    String responseBy = (String) session.getAttribute("loggedInUserId");
    int itemId = Integer.parseInt(request.getParameter("itemId"));

    try {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO responses (response_text, response_by, item_id, is_valid) VALUES (?, ?, ?, 'Pending')";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, responseText);
        pstmt.setString(2, responseBy);
        pstmt.setInt(3, itemId);
        pstmt.executeUpdate();
        conn.close();

        response.sendRedirect("item.jsp?id=" + itemId); // Redirect to home page after creating response
    } catch (SQLException e) {
        out.println("<p>Error creating response: " + e.getMessage() + "</p>");
    }
}
%>
