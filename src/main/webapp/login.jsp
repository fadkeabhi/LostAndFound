<%@ page import="java.sql.*, db.DBUtil" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
if (session.getAttribute("loggedInUserEmail") != null) {
    // Redirect user to home page if already logged in
    response.sendRedirect("home.jsp");
}

if (request.getMethod().equals("POST")) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            // Authentication successful
            session.setAttribute("loggedInUserEmail", email);
            session.setAttribute("loggedInUserId", rs.getString("user_id"));
            session.setAttribute("loggedInUserName", rs.getString("first_name"));
            out.println();
            response.sendRedirect("feed.jsp");
        } else {
            // Authentication failed
            out.println("<p>Invalid email or password. Please try again.</p>");
        }

        conn.close();
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

    <style>
        body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background-color: #8a34e7; /* Set your desired background color */
    }

    .login-container {
        width: 300px;
        /* max-width: 400px; */
        /* margin: 100px auto;  */
        background-color: #c6a1e8;
        padding: 20px;
        border-radius: 8px;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%,-50%);
        /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
    }
    .login-container h2 {
        text-align: center;
    }
    .login-container form {
        display: flex;
        flex-direction: column;
    }
    .login-container input[type="email"],
    .login-container input[type="password"],
    .login-container input[type="submit"] {
        margin-bottom: 10px;
        padding: 10px;
        border: 1px solid #7b17e5;;
        border-radius: 5px;
    }
    .login-container input[type="submit"] {
        background-color: #4CAF50; /* Green */
        color: white;
        cursor: pointer;
    }
    .login-container input[type="submit"]:hover {
        background-color: #45a049; /* Darker green */
    }
    .but
    {
        width: 40%;
    }
    </style>
</head>
<body>
    <div class="login-container">
        <form method="post" action="login.jsp">
            <h2>Login</h2>

            <label for="emil">Email:</label><br>
            <input type="email" name="email" placeholder="Enter your email" required><br>

            <label for="password">Password:</label><br>
            <input type="password" name="password" placeholder="Enter password" required><br>

            <input type="submit" value="submit" class="but">
        </form>
    </div>
    
</body>
</html>



