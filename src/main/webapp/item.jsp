<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./css/style.css" />
    <link rel="stylesheet" href="./css/slider.css" />
    <title>Lost And Found</title>
  </head>

  <body id="body">
    <jsp:include page="./header.jsp" />
    
    <%-- Retrieve item ID from request parameter --%>
    <% String itemIdParam = request.getParameter("id");
       int itemId = Integer.parseInt(itemIdParam); // Assuming itemIdParam is the item ID passed from another page
       int postedBy = 0;
    %>
    
   
    <%-- Retrieve item details from database --%>
    <% try {
           Connection conn = DBUtil.getConnection();
           String sql = "SELECT * FROM items LEFT JOIN users ON users.user_id = items.posted_by WHERE item_id = ? AND is_active=1";
           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, itemId);
           ResultSet rs = pstmt.executeQuery();
           if (rs.next()) {
               String itemName = rs.getString("item_name");
               String description = rs.getString("description");
               String question = rs.getString("question");
               String itemType = rs.getString("item_type");
               String postedByString = rs.getString("posted_by");
               String postedByFName = rs.getString("first_name");
               String postedByLName = rs.getString("last_name");
               String postedByPhone = rs.getString("phone_number");
               String posted_at = rs.getString("posted_at");
               
               postedBy = Integer.parseInt(postedByString);
               
               // Display item details
    %>
    
    
        <!-- upload_image_div form  -->
    <div class="post_item" id="upload_image_div">
        <h2>Upload image</h2>
        <form action="upload?id=<%= itemId %>" method="post" enctype="multipart/form-data">
            <label for="file">Select Image:</label><br>
            <input type="file" id="file" name="file" accept="image/*" required><br><br>
            
            <input type="submit" value="Upload" class="but" id="green">
            <input type="button" value="Close" class="but" id="red" id="close_but" onclick="hideImageForm()">
        </form>
    </div>
    
    <!-- delete_item_div form  -->
    <div class="post_item" id="delete_item_div">
        <h2>Delete Item</h2>
        <form action="item_delete.jsp" method="post">
        
            <input type="text" id="itemIdDelete" name="itemId" hidden="hidden" required value="<%= itemId %>">
            Are you sure you want to delete this item. This action can't be undone.
            <br>
            <input type="submit" value=Delete class="but" id="red">
            <input type="button" value="Close" class="but" id="green" id="close_but" onclick="hideDeleteForm()">
        </form>
    </div>
    
    
    <!-- edit_item_div form -->
    <div class="post_item" id="edit_item_div">
        <h2>Edit item</h2>
        <form method="post" action="item_edit.jsp">
        	
            <input type="text" id="itemId" name="itemId" required hidden="hidden" value="<%= itemId %>"><br>
            <label for="itemName">item name*</label><br>
            <input type="text" id="itemName" name="itemName" required placeholder="Enter item" value="<%= itemName %>"><br>
            <label for="description">Description*</label><br>
            <input type="text" id="description" name="description" required placeholder="short description" value="<%= description %>"><br>
            <label for="question">Enter a Question Based on the item*</label><br>
            <input type="text" id="question" name="question" required placeholder="question" value="<%= question %>"><br>

            

            <input type="submit" value="Submit" class="but" id="green">
            <input type="button" value="Close" class="but" id="red" id="close_but" onclick="hideEditForm()">
        </form>
    </div>
    
    <!-- response_item_div form -->
    <div class="post_item" id="response_item_div">
        <h2>Response</h2>
        <form method="post" action="response_create.jsp">
        	
            <input type="text" id="itemId" name="itemId" required hidden="hidden" value="<%= itemId %>"><br>
            
            <label for="question">Enter Your Response*</label><br>
            <textarea name="ressponse_text" required placeholder="Response" style="width:100%"></textarea>
           
           <br>
            <input type="submit" value="Submit" class="but" id="green">
            <input type="button" value="Close" class="but" id="red" id="close_but" onclick="hideResponseForm()">
        </form>
    </div>


    <div class="container">
      <div class="container1">
        <!-- main images -->
        <div class="holder">

            <%
               //Display image
		           sql = "SELECT * FROM item_photos WHERE item_id = ?";
		           pstmt = conn.prepareStatement(sql);
		           pstmt.setInt(1, itemId);
		           ResultSet rs1 = pstmt.executeQuery();
		           
		           while (rs1.next()) {
                       %>
                        <div class="slides">
                            <img src="display?file=<%= rs1.getString("photo_name")%>" alt="image" />
                        </div>
                       <%
		           }
               %>

        </div>

        <div class="prevContainer">
          <a class="prev" onclick="plusSlides(-1)">
            <svg viewBox="0 0 24 24">
              <path
                d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"
              ></path>
            </svg>
          </a>
        </div>
        <div class="nextContainer">
          <a class="next" onclick="plusSlides(1)">
            <svg viewBox="0 0 24 24">
              <path
                d="M4,11V13H16L10.5,18.5L11.92,19.92L19.84,12L11.92,4.08L10.5,5.5L16,11H4Z"
              ></path>
            </svg>
          </a>
        </div>
        <hr />

        <!-- thumnails in a row -->
        <div class="row">

            <%
               //Display image
		           sql = "SELECT * FROM item_photos WHERE item_id = ?";
		           pstmt = conn.prepareStatement(sql);
		           pstmt.setInt(1, itemId);
		           rs1 = pstmt.executeQuery();
		           
                   int i = 1;
		           while (rs1.next()) {
                       %>
                        <div class="column">
                            <img
                            class="slide-thumbnail"
                            src="display?file=<%= rs1.getString("photo_name")%>"
                            onclick="currentSlide(<%= i++ %>)"
                            alt="Caption Two"
                            />
                        </div>
                       <%
		           }
               %>
          
        </div>
      </div>
      <div class="container2">
        <div class="content">
          <div class="item">
            <span>Item name:</span>
            <span class="from_user"><%= itemName %></span>
          </div>
          <div class="item">
            <span>Item description:</span>
            <span class="from_user"><%= description %></span>
          </div>
          <div class="item">
            <span>Item type:</span>
            <span class="from_user"><%= itemType %></span>
          </div>
          <div class="item">
            <span>Question:</span>
            <span class="from_user"><%= question %></span>
          </div>
          <div class="item">
            <span>Posted By Name:</span>
            <span class="from_user"><%= postedByFName  %> <%= postedByLName  %></span>
          </div>
          <div class="item">
            <span>Created at:</span>
            <span class="from_user"><%= posted_at %></span>
          </div>
          <div class="item" id="item1">
          
          
          <% if(postedBy == userId) { %>
  
            <button id="red" class="but1" onclick="displayDeleteForm()">
                Delete item
            </button>
            <button id="blue" class="but1" onclick="displayEditForm()">
                Edit item
            </button>
            <button id="green" class="but1" onclick="displayImageForm()">
                Upload image
            </button>
            <% } else{
            
               sql = "SELECT * FROM responses WHERE item_id = ? AND response_by = ? AND is_valid = 'Accepted'";
	           pstmt = conn.prepareStatement(sql);
	           pstmt.setInt(1, itemId);
	           pstmt.setInt(2, userId);
	           ResultSet rs2 = pstmt.executeQuery();
	           
	           if (rs2.next()) {
                       %>
                        Contact : <%= postedByPhone %>
                       <%
		           } else { %>
  
            <button id="blue" class="but1" onclick="displayResponseForm()">
                Respond
            </button>
            
            <% }%>
            <% }%>
          </div>
        </div>
      </div>
    </div>
    <hr>
    
    <% if(postedBy == userId) { %>
    
    <div class="question question1">
      <h3>Responses:</h3>
      <div class="inner-content">
      
      <%
	      sql = "SELECT * FROM responses WHERE item_id = ?";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setInt(1, itemId);
	      rs = pstmt.executeQuery();
	      while (rs.next()) {
	          %>

	          	<div class="content content1">
		          <div class="item">
		            <span >Answer to Your Question:</span>
		            <span class="from_user"><%= rs.getString("response_text") %></span>
		          </div>
		          
		          <% if(rs.getString("is_valid").equals("Pending") ) { %>
		          <div class="item" id="item1">
		            <button id="green" class="but1 but11" onclick="location.href='response_update.jsp?item_id=<%= itemId%>&response_id=<%= rs.getString("response_id")%>&status=1'">
		              Accept
		            </button>
		            <button id="red" class="but1 but11" onclick="location.href='response_update.jsp?item_id=<%= itemId%>&response_id=<%= rs.getString("response_id")%>&status=2'">
		              Reject
		            </button>    
		          </div>
		          <% } else { %>
		          <div class="item" id="item1">
		            <%= rs.getString("is_valid") %>
		          </div>
		          <% } %>
		          
		        </div>
		        
	          <%
	      }

	      %>
	      
      </div>
    </div>
    
    <% }
    // end of if statment
    %>

    
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

    <%
//  Questions section below
    %>
    
    

    
    


    
    <script>
		function displayImageForm()
		{
		    document.getElementById("upload_image_div").style.display="block";
		}
		function hideImageForm()
		{
		    document.getElementById("upload_image_div").style.display="none";
		}
	</script>
	
	<script>
		function displayEditForm()
		{
		    document.getElementById("edit_item_div").style.display="block";
		}
		function hideEditForm()
		{
		    document.getElementById("edit_item_div").style.display="none";
		}
	</script>
	
	<script>
		function displayDeleteForm()
		{
		    document.getElementById("delete_item_div").style.display="block";
		}
		function hideDeleteForm()
		{
		    document.getElementById("delete_item_div").style.display="none";
		}
	</script>
	
		<script>
		function displayResponseForm()
		{
		    document.getElementById("response_item_div").style.display="block";
		}
		function hideResponseForm()
		{
		    document.getElementById("response_item_div").style.display="none";
		}
	</script>


    <script src="./js/slider.js"></script>
    <jsp:include page="./footer.jsp" />
  </body>
</html>

