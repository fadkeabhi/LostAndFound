<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%


if (session.getAttribute("loggedInUserEmail") != null) {
    // Redirect user to home page if already logged in
    response.sendRedirect("feed.jsp");
} 

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lost and Found</title>
    <link rel="stylesheet" href="./css/style.css">
</head>

<body>
    <header>
        <nav>
            <ul>
                <li><a href="login.jsp" class="navElement">Login</a></li>
                <li><a href="signup.jsp" class="navElement">Sign Up</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <h1>Lost and Found</h1>
    </div>
    <div class="text-content">
        <p>Find your lost items here...</p>
        <p>Upload items you found...</p>
    </div>
</body>
</html>