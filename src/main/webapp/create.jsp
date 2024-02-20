<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBUtil" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create New Item</title>
</head>
<body>
    <h1>Create New Lost or Found Item</h1>
    <form method="post" action="create_item.jsp">
        <label for="itemName">Item Name:</label><br>
        <input type="text" id="itemName" name="itemName" required><br>
        
        <label for="description">Description:</label><br>
        <textarea id="description" name="description" required></textarea><br>
        
        <label for="question">Question:</label><br>
        <input type="text" id="question" name="question"><br>
        
        <label for="itemType">Item Type:</label><br>
        <select id="itemType" name="itemType" required>
            <option value="Lost">Lost</option>
            <option value="Found">Found</option>
        </select><br>
        
        <input type="submit" value="Create Item">
    </form>
</body>
</html>
