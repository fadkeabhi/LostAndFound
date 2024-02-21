<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String username = "";
if (session.getAttribute("loggedInUserEmail") == null) {
    // Redirect user to home page if already logged in
    response.sendRedirect("index.jsp");
    return;
} else{
	username = session.getAttribute("loggedInUserName").toString();
}
%>


<header>
    <nav>
        <ul>
            <li class="heading">Lost and Found</li>
            <li><a class="navElement" onclick="displayItemForm()">Post item</a></li>
            <li><a href="feed.jsp" class="navElement">Feed</a></li>
            <li><a href="responses.jsp" class="navElement">Responses</a></li>
            <li><a href="my_listing.jsp" class="navElement">My listings</a></li>
            <li><a href="./logout.jsp" class="navElement">Sign out</a></li>
        </ul>
    </nav>
</header>

<!-- hidden cards -->
    <div class="post_item" id="post_item">
        <h2>Post item</h2>
        <form method="post" action="item_create.jsp">
            <label for="itemName">item name*</label><br>
            <input type="text" id="itemName" name="itemName" required placeholder="Enter item"><br>
            <label for="description">Description*</label><br>
            <input type="text" id="description" name="description" required placeholder="short description"><br>
            <label for="question">Enter a Question Based on the item*</label><br>
            <input type="text" id="question" name="question" required placeholder="question"><br>
            <label for="itemType">item type*</label><br>
            <select name="itemType" id="itemType">
                <option value="" selected disabled hidden>Choose here</option>
                <option value="Lost">Lost</option>
                <option value="Found">Found</option>
            </select><br>
            <!-- <label for="image">Image</label><br>
            <input type="file" id="image" name="image"><br> -->

            <input type="submit" value="Submit" class="but" id="green">
            <input type="button" value="Close" class="but" id="red" id="close_but" onclick="backToHome()">
        </form>
    </div>

<h3>Welcome <%= username %></h3>