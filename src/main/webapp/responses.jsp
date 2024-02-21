<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.DBUtil" %>
<%
if (session.getAttribute("loggedInUserEmail") == null) {
    response.sendRedirect("index.jsp");
    return;
} 
String userIdString = session.getAttribute("loggedInUserId").toString();
int userId = Integer.parseInt(userIdString);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/slider.css">
    <title>Lost And Found</title>
</head>

  <body id="body">
    <jsp:include page="./header.jsp" />

    <div class="card_heading">
      <span>
          Your Responses:
      </span>
    </div>
    
    <div style="display:flex">
    
    <% 
    Connection conn = DBUtil.getConnection();
            String sql = "SELECT item_name, description, item_type, posted_at, items.item_id FROM `responses` LEFT JOIN items ON items.item_id = responses.item_id WHERE response_by = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
            	%>
            	
            	<div class="content content1">
			        <div class="item">
			          <span>Item name:</span>
			          <span class="from_user"><%= rs.getString("item_name") %></span>
			        </div>
			        <div class="item">
			          <span>Item description:</span>
			          <span class="from_user"><%= rs.getString("description") %></span>
			        </div>
			        <div class="item">
			          <span>Item type:</span>
			          <span class="from_user"><%= rs.getString("item_type") %></span>
			        </div>
			        <div class="item">
			          <span>Created at:</span>
			          <span class="from_user"><%= rs.getString("posted_at") %></span>
			        </div>
			        <div class="item" id="item1">
			          <button id="green" class="but1 but2" onclick="location.href='item.jsp?id=<%= rs.getString("item_id")%>'">
			              View Item
			          </button>
			        </div>
			      </div>
            	
            	<% 
            }
            	%>
    
      
      
  
      
    </div>

   

    
<jsp:include page="./footer.jsp" />
  </body>
</html>
