package files;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;



/**
 * Servlet implementation class display
 */
public class display extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public display() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// set the content type to image/jpeg. 
		
		String fileName = request.getParameter("file");
        response.setContentType("image/jpeg");   
          
        ServletOutputStream out; 
          
        // Writing this image  
        // content as a response  
        out = response.getOutputStream();  
          
        // path of the image 
        FileInputStream fin = new FileInputStream("C:\\Users\\fadke\\eclipse-workspace\\LostAndFound\\src\\main\\webapp\\uploads\\" + fileName);   
  
        // getting image in BufferedInputStream   
        BufferedInputStream bin = new BufferedInputStream(fin); 
        BufferedOutputStream bout = new BufferedOutputStream(out);   
          
        int ch =0;   
        while((ch=bin.read())!=-1)   
        {   
            // display image 
            bout.write(ch);   
        }   
          
        // close all classes 
        bin.close();   
        fin.close();   
        bout.close();   
        out.close();   
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
