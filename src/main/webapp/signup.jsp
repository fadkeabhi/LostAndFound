<%@ page import="java.sql.*, db.DBUtil" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
if (request.getMethod().equals("POST")) {
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");

    try {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO users (first_name, last_name, email, phone_number, password) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, email);
        pstmt.setString(4, phone);
        pstmt.setString(5, password);
        pstmt.executeUpdate();
        response.sendRedirect("login.jsp?msg=Sign up successful");
        out.println("<p>Sign up successful!</p>");
        conn.close();
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>



    <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SignUp</title>

    <style>
      body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background-color: #8a34e7; /* Set your desired background color */
      }
      .signup-container {
        width: 500px;
        min-width: 400px;
        position: absolute;
        top: 15%;
        left: 50%;
        transform: translate(-50%);
        background-color: #c6a1e8;
        padding: 20px;
        border-radius: 8px;
        /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
      }
      .signup-container h2 {
        text-align: center;
      }
      .signup-container form {
        display: flex;
        flex-direction: column;
      }
      .signup-container form .input-group {
        display: flex;
        margin-bottom: 10px;
      }
      .signup-container form .input-group input {
        flex: 1;
        padding: 10px;
        border: 1px solid #7b17e5;
        border-radius: 5px;
        width: 90%;
      }
      .item
      {
        width: 100%;
      }
      .signup-container input[type="submit"] {
        background-color: #4caf50; /* Green */
        color: white;
        cursor: pointer;
        border: none;
        border-radius: 5px;
        padding: 10px;
        transition: background-color 0.3s;
      }
      .signup-container input[type="submit"]:hover {
        background-color: #45a049; /* Darker green */
      }
    </style>
  </head>
  <body>
    <div class="signup-container">
      <form method="post" action="signup.jsp">
        <h2>SignUp</h2>
        <div class="input-group">
          <div class="item">
            <label for="firstName">First Name:</label><br />
            <input
              type="text"
              name="firstName"
              placeholder="Enter first name"
              required
            /><br />
          </div>
          <div class="item">
            <label for="lastName">Last Name:</label><br />
            <input
              type="text"
              name="lastName"
              placeholder="Enter last name"
              required
            /><br />
          </div>
        </div>

        <div class="input-group">
          <div class="item">
            <label for="email">Email:</label><br />
            <input
              type="email"
              name="email"
              placeholder="Enter your email"
              required
            /><br />
          </div>

          <div class="item">
            <label for="phone">Phone Number:</label><br />
            <input
              type="number"
              name="phone"
              placeholder="Enter phone number"
              required
            /><br />
          </div>
        </div>

        <div class="input-group">
          <div class="item">
            <label for="password">Password:</label><br />
            <input
              type="password"
              name="password"
              placeholder="Enter password"
              required
            /><br />
          </div>

          <div class="item">
            <label for="password1">Confirm Password:</label><br />
            <input
              type="password"
              name="password1"
              placeholder="Enter password"
              required
            /><br />
          </div>
        </div>

        <input type="submit" value="submit">
      </form>
    </div>
  </body>
</html>
