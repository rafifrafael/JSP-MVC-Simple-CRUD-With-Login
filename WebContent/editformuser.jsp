<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hello</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
  
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
  	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
  </head>
  <body>
  
   <%@page import="com.info.EditUser, com.info.Data"%> 
   
    <%
		String uid = (String)session.getAttribute("username");
      	String type = (String)session.getAttribute("type");
		if (uid == null || session.getAttribute("type").equals("user"))
		{
			%><!-- NOT A VALID USER, IF THE USER TRIES TO EXECUTE LOGGED IN PAGE DIRECTLY, ACCESS IS RESTRICTED -->
				<jsp:forward page="logout.jsp"/>
			<%	
		}
	%>
  
    <h1>HEADER</h1>
    
    <nav class="navbar navbar-expand-lg bg-light">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="#">Navbar</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarNav">
	      <ul class="navbar-nav">
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="admin.jsp">Home</a>
	        </li>
	      </ul>
	    </div>
	    
	    <!-- Right elements -->
    <div class="d-flex align-items-center">
        <%  
			String idL=(String)session.getAttribute("id");  
			Data dL=EditUser.getRecordById(Integer.parseInt(idL)); 
		%>
	
    	<img src="getimageuser.jsp?id=<%=dL.getId() %>" width="50px">
		
      	<%	
			out.println(" Welcome! " +uid);
		%>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="logout.jsp">Logout</a>
				</li>
			</ul>
		</div>

 
    </div>
    <!-- Right elements -->
	  </div>
	</nav>
	<br><br><br>
	
	<%  
		String id=request.getParameter("id");
		Data d=EditUser.getRecordById(Integer.parseInt(id));  
	%>
	
	<h2 align="center">Edit Data</h2>
	
	<form action="./edituser" method="post" class="w-25 mx-auto">
		<div class="container">
		
			<input type=hidden name="id" value="<%=d.getId() %>" >
			
			<div class="mb-3">
				<label for="education" class="form-label">Name</label>
				<input type="text" class="form-control" id="name" name="name" value="<%=d.getName() %>">
			</div>
			<div class="mb-3">
				<label for="education" class="form-label">Username</label>
				<input type="text" class="form-control" id="username" name="username" value="<%=d.getUsername() %>">
			</div>
			<div class="mb-3">
				<label for="education" class="form-label">Email</label>
				<input type="text" class="form-control" id="email" name="email" value="<%=d.getEmail() %>">
			</div>
			<div class="mb-3">
				<label for="education" class="form-label">Password</label>
				<input type="password" class="form-control" id="password" name="password" value="<%=d.getPassword() %>">
			</div>
			<div class="mb-3">
				<label for="education" class="form-label">Phone</label>
				<input type="text" class="form-control" id="phone" name="phone" value="<%=d.getPhone() %>">
			</div>			
			<div class="input-group mb-3">
			  <label class="input-group-text" for="inputGroupSelect01">Type</label>
			  <select class="form-select" id="type" name="type">
			    <option selected><%=d.getType() %></option>
			    <option value="admin">Admin</option>
			    <option value="user">User<option>
			  </select>
			</div>
			<div class="mb-3">
				<a href="./changepic.jsp?id=<%=d.getId()%>" class="btn btn-success">Change Profile Picture</a>
			</div>
			
			<div class="mb-3">
				<input type="submit" class="btn btn-primary" value="Submit">
				<a href="admin.jsp" class="btn btn-danger">Cancel</a>
			</div>
		</div>
	</form>
	
	<footer class="fixed-bottom bg-light text-center text-lg-start">
	  <!-- Copyright -->
	  <div class="text-center p-3">
	    © 2022 Copyright:
	    Rafif Murtadho
	  </div>
	  <!-- Copyright -->
	</footer>

</body>
</html>