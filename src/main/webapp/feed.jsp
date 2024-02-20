<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.DBUtil" %>
<%
if (session.getAttribute("loggedInUserEmail") == null) {
    response.sendRedirect("index.jsp");
    return;
} 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">
    <title>Lost And Found</title>
</head>
<body>
	<jsp:include page="./header.jsp" />
    <div class="card_heading">
        <span>
            Lost Items:
        </span>
    </div>
    
    
    <div class="content">
    
    <%
    	// Creating cards using jsp
    	try {
    		Connection conn = DBUtil.getConnection();
            String sql = "SELECT * FROM items LEFT JOIN item_photos ON item_photos.item_id = items.item_id WHERE items.is_active = 1 AND item_type = 'Lost' GROUP BY items.item_id";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
            	String itemId = rs.getString("item_id");
            	String photoName = rs.getString("photo_name");
            	if(photoName == null){
            		photoName = "../No_Image_Available.jpg";
            	}
            	String itemName = rs.getString("item_name");
            	String itemDescription = rs.getString("description");
            	if (itemDescription.length() > 20){
                	itemDescription = itemDescription.substring(0, Math.min(itemDescription.length(), 20)) + " ....";      		
            	}
            	String postedOn = rs.getString("posted_at");

            	%>
            	
            	<div class="card" onclick="location.href='item.jsp?id=<%= itemId %>';">
		            <div class="card_image">
		                <img src="./uploads/<%= photoName %>" alt="Avatar" style="width:80%">
		            </div>
		            <div class="card_content">
		                <p class="card_item">Item: <span><%= itemName %></span></p>
		                <p class="card_item">Description: <span><%= itemDescription %></span></p>
		                <p class="card_item" id="current_time">Posted at: <span><%= postedOn %></span></p>
		            </div>
		        </div>
	        	
	        	<% 
	        }
            
    	} catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>

    </div>
    
    
    
    <div class="card_heading">
        <span>
            Found Items:
        </span>
    </div>
    
    <div class="content">
    
    <%
    	// Creating cards using jsp
    	try {
    		Connection conn = DBUtil.getConnection();
            String sql = "SELECT * FROM items LEFT JOIN item_photos ON item_photos.item_id = items.item_id WHERE items.is_active = 1 AND item_type = 'Found' GROUP BY items.item_id";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
            	String itemId = rs.getString("item_id");
            	String photoName = rs.getString("photo_name");
            	if(photoName == null){
            		photoName = "../No_Image_Available.jpg";
            	}
            	String itemName = rs.getString("item_name");
            	String itemDescription = rs.getString("description");
            	if (itemDescription.length() > 20){
                	itemDescription = itemDescription.substring(0, Math.min(itemDescription.length(), 20)) + " ....";      		
            	}
            	String postedOn = rs.getString("posted_at");

            	%>
            	
            	<div class="card" onclick="location.href='item.jsp?id=<%= itemId %>';">
		            <div class="card_image">
		                <img src="./uploads/<%= photoName %>" alt="Avatar" style="width:80%">
		            </div>
		            <div class="card_content">
		                <p class="card_item">Item: <span><%= itemName %></span></p>
		                <p class="card_item">Description: <span><%= itemDescription %></span></p>
		                <p class="card_item" id="current_time">Posted at: <span><%= postedOn %></span></p>
		            </div>
		        </div>
	        	
	        	<% 
	        }
            
    	} catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>

    </div>

<jsp:include page="./footer.jsp" />
    
</body>
</html>
