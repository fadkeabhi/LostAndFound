<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>

<%
    // Invalidate the session to log the user out
    session.invalidate();
    
    // Redirect the user to the login page or any other page
    response.sendRedirect("index.jsp");
%>
