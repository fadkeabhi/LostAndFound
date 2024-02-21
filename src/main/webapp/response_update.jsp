<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBUtil" %>

<%
// Check if the item ID is provided in the request
if (request.getMethod().equals("GET")) {

    int itemId = Integer.parseInt(request.getParameter("item_id"));
    int responseId = Integer.parseInt(request.getParameter("response_id"));
    int statusNum = Integer.parseInt(request.getParameter("status"));
    String status = "";
    
    if(statusNum == 1){
    	status = "Accepted";
    } else if(statusNum == 2){
    	status = "Rejected";
    } else{
    	status = "Pending";
    }
    
    
    try {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE responses SET is_valid = ? WHERE response_id = ? ";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, status);
        pstmt.setInt(2, responseId);
        pstmt.executeUpdate();
        
        conn.close();
        
        // Redirect to a success page or back to the item list page
        response.sendRedirect("item.jsp?id=" + itemId);
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
} else {
    // Handle the case where the item ID is not provided
    out.println("<p>Error: Item ID not provided.</p>");
}

%>
