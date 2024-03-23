package files;

import java.io.*;
import java.io.File.*;
import java.io.IOException.*;

import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;

import db.DBUtil;

/**
 * Servlet implementation class response_create
 */
//@WebServlet("/response_create")
@MultipartConfig
public class response_create extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public response_create() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String responseText = request.getParameter("response_text");
        String responseBy = (String) session.getAttribute("loggedInUserId");
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        
        String uploadDir = "C:\\Users\\fadke\\eclipse-workspace\\LostAndFound\\src\\main\\webapp\\uploads\\"; // Change the path as needed
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        UUID uuid = UUID.randomUUID();
        
        String fileName = uuid.toString() + Paths.get(request.getPart("file").getSubmittedFileName()).getFileName().toString() + ".png";
        InputStream fileContent = request.getPart("file").getInputStream();
        
        try (OutputStream out = new FileOutputStream(new File(uploadDir + fileName))) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            
//            If no error occured insert the record to database
            
            Connection conn = DBUtil.getConnection();
            String sql = "INSERT INTO responses (response_text, response_by, item_id, is_valid, response_image) VALUES (?, ?, ?, 'Pending', ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, responseText);
            pstmt.setString(2, responseBy);
            pstmt.setInt(3, itemId);
            pstmt.setString(4, fileName);
            pstmt.executeUpdate();
            conn.close();
            
            
            response.sendRedirect("./item.jsp?id=" + itemId);
            response.getWriter().println("File uploaded successfully.");
        } catch (IOException e) {
            response.getWriter().println("File upload failed due to " + e);
        } catch (SQLException e) {
        	response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
        } 
        finally {
            fileContent.close();
        }
        

        
    }

}
