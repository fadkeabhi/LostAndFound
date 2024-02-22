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
    <style>
		.container-small
		{
		    font-family: 'Times New Roman', Times, serif;
		    font-size: 30px;
		    margin-left: 20px;
		}
		
		.container
		{
		    display: flex;
		}
		.container1
		{
		    width: 50%;
		}
		.container2
		{
		    width: 50%;
		}
		.container3
		{
		    width: 50%;
		}
		.container4
		{
		    width: 50%;
		    text-align: center;
		}
		.butt
		{
		    color: white;
		    background-color: rgb(17, 17, 150) ;
		    padding: 10px;
		    border: none;
		    font-size: 15px;
		    border-radius: 5px;
		}
		.inspiration
		{
		    color: rgb(17, 17, 150);
		    font-family: 'Times New Roman', Times, serif;
		    margin-top: 80px;
		}
		.discription
		{
		    margin-top: 20px;
		    margin-bottom: 30px;
		    padding-left: 20px;
		    padding-right: 20px;
		}
    </style>
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
        <div class="container1">
            <div class="container-small">
                <h1>Lost and Found</h1>
            </div>
            <div class="text-content">
                <p>Find your lost items here...</p>
                <p>Upload items you found...</p>
            </div>
        </div>
        <div class="container2">
            <img src="images/image-1.png" alt="image" width="600px" height="auto">
        </div>
    </div>
    <div class="container">
        <div class="container3">
            <img src="images/image-2.png" alt="image" width="600px" height="auto">
        </div>
        <div class="container4">
            <div class="inspiration">
                <h1>MY PROJECT INSPIRATION</h1>
            </div>
            <div >
                <p class="discription" >My project inspiration is to create a platform where people can find their lost items and also upload items they found. This platform will help people to find their lost items easily and also help people to return items they found to the owner. This platform will also help to reduce the rate of lost items in the society.</p>
            </div>
            <div>
                <button class="butt">Get Started</button>
            </div>
        </div>
    </div>
</body>
</html>