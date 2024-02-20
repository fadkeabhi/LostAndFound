<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <title>Item Details</title>
</head>
<body>
    <h1>Item Details</h1>
    
    <%-- Retrieve item ID from request parameter --%>
    <% String itemIdParam = request.getParameter("id");
       int itemId = Integer.parseInt(itemIdParam); // Assuming itemIdParam is the item ID passed from another page
    %>
    
    <%-- Retrieve item details from database --%>
    <% try {
           Connection conn = DBUtil.getConnection();
           String sql = "SELECT * FROM items LEFT JOIN users ON users.user_id = items.posted_by WHERE item_id = ?";
           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, itemId);
           ResultSet rs = pstmt.executeQuery();
           if (rs.next()) {
               String itemName = rs.getString("item_name");
               String description = rs.getString("description");
               String question = rs.getString("question");
               String itemType = rs.getString("item_type");
               String postedBy = rs.getString("posted_by");
               String postedByFName = rs.getString("first_name");
               String postedByLName = rs.getString("last_name");
               String postedByPhone = rs.getString("phone_number");
               
               // Display item details
    %>
               <p><strong>Item Name:</strong> <%= itemName %></p>
               <p><strong>Description:</strong> <%= description %></p>
               <p><strong>Question:</strong> <%= question %></p>
               <p><strong>Item Type:</strong> <%= itemType %></p>
               <p><strong>Posted By ID:</strong> <%= postedBy %></p>
               <p><strong>Posted By Name:</strong> <%= postedByFName  %> <%= postedByLName  %></p>
               <p><strong>Posted By Phone:</strong> <%= postedByPhone %></p>
               
               
               <%
               //Display image
		           sql = "SELECT * FROM item_photos WHERE item_id = ?";
		           pstmt = conn.prepareStatement(sql);
		           pstmt.setInt(1, itemId);
		           ResultSet rs1 = pstmt.executeQuery();
		           
		           while (rs1.next()) {
		               out.println("<img src='./uploads/" + rs1.getString("photo_name") + "'/>");

		           }
               %>
               
               
               <form action="upload?id=<%= itemId %>" method="post" enctype="multipart/form-data">
			        <label for="file">Select Image:</label>
			        <input type="file" id="file" name="file" accept="image/*"><br><br>
			        <input type="submit" value="Upload">
			    </form>
    
    <%         } else {
                   // Item not found
                   out.println("<p>Item not found</p>");
               }
               rs.close();
               conn.close();
           } catch (SQLException e) {
               out.println("<p>Error: " + e.getMessage() + "</p>");
           }
    %>
</body>
</html>
