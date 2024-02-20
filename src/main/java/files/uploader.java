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

import jakarta.servlet.annotation.WebServlet;

import db.DBUtil;

@WebServlet("/upload")
@MultipartConfig

public class uploader extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("DJABRJ Served at: ").append(request.getContextPath());
    }  

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            
            
            // Update filename to database
            int itemId = Integer.parseInt(request.getParameter("id"));
            
            
            Connection conn = DBUtil.getConnection();
            String sql = "INSERT INTO `item_photos` (`item_id`, `photo_name`) VALUES (?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, itemId);
            pstmt.setString(2, fileName);
            pstmt.executeUpdate();
            
            
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
