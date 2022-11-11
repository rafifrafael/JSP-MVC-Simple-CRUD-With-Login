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
public class InsertUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		// getting request value from form page -3
		String uname = request.getParameter ("name");
		String uusername = request.getParameter ("username");
		String upassword = request.getParameter ("password");
		String uemail = request.getParameter ("email");
		String uphone = request.getParameter ("phone");
		String type = "user";
		Part uphoto = request.getPart("photo");
		
		
		try {
			Connection con = DBConn.initializeDatabase();
			PreparedStatement st = con.prepareStatement ("insert into user (name, username, password, email, phone, photo, type)"
					+ " values(?, ?, ?, ?, ?, ?, ?)");

			
			st.setString(1, uname);
			st.setString(2, uusername);
			st.setString(3, upassword);
			st.setString(4, uemail);
			st.setString(5, uphone);
			InputStream is = uphoto.getInputStream();
			st.setBlob(6, is);
			st.setString(7, type);
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
			response.sendRedirect("http://localhost:8080/Assignment2/");
		}
		catch (Exception e) {
			e.printStackTrace();
			PrintWriter out = response.getWriter();
			out.println ("<html><body><b>something error"	+ "</b></body></html>") ;
		}
		
	}

}
