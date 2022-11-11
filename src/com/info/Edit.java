package com.info;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class Edit
 */
@MultipartConfig(maxFileSize = 16177216)//1.5mb
public class Edit extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int uid = Integer.parseInt(request.getParameter("id"));
		
		Part ufile = request.getPart("file");
		String ufileName = ufile.getSubmittedFileName();
		
		String ucomment = request.getParameter ("comment");
		
		PrintWriter out1 = response.getWriter();
		out1.println(uid);
		
		try {
			
			Connection con = DBConn.initializeDatabase();
			PreparedStatement st = con.prepareStatement("update input set file=?, filename=?, comment=? where id=?");			
			
			InputStream is = ufile.getInputStream();
			st.setBlob(1, is);			
			st.setString(2, ufileName);
			st.setString(3, ucomment);
			st.setInt(4, uid);
			
			st.executeUpdate () ;
			
			st.close();
			con.close();
			// Get a writer pointer
			// to display the successful result
			PrintWriter out = response.getWriter();
			out.println ("<html><body><b>Successfully Updated"	+ "</b></body></html>") ;
			response.sendRedirect("http://localhost:8080/Assignment2/record.jsp");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public static Data getRecordById(int id){  
	    Data d=null;  
	    try{  
	    	Connection con = DBConn.initializeDatabase(); 
	        PreparedStatement ps=con.prepareStatement("select * from input where id=?");  
	        ps.setInt(1,id);  
	        ResultSet rs=ps.executeQuery();  
	        while(rs.next()){  
	            d=new Data();  
	            d.setId(rs.getInt("id"));
	            d.setName(rs.getString("name"));
	            d.setComment(rs.getString("comment"));
	        }  
	    }catch(Exception e){System.out.println(e);}  
	    	return d;  
	} 

}
