package com.info;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class Servlet3
 */
@MultipartConfig(maxFileSize = 16177216)//1.5mb
public class Insert extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		// getting request value from form page -3
		String uname = request.getParameter ("name");
		String uemail = request.getParameter ("email");
		Part ufile = request.getPart("file");
		String ufileName = ufile.getSubmittedFileName();
		
		String ucomment = request.getParameter ("comment");
		
		
		try {
			Connection con = DBConn.initializeDatabase();
			PreparedStatement st = con.prepareStatement ("insert into input (name, email, file, filename, comment)"
					+ " values(?, ?, ?, ?, ?)");

			
			st.setString(1, uname);
			st.setString(2, uemail);
			InputStream is = ufile.getInputStream();
			st.setBlob(3, is);			
			st.setString(4, ufileName);
			st.setString(5, ucomment);
			// Execute the insert command using executeUpdate ()
			// to make changes in database
			st.executeUpdate () ;
			// Close all the connections
			st.close();
			con.close();
			// Get a writer pointer
			// to display the successful result
			PrintWriter out = response.getWriter();
			out.println ("<html><body><b>Successfully Inserted"	+ "</b></body></html>") ;
			response.sendRedirect("./user.jsp");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
