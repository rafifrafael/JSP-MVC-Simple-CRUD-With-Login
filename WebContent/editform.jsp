<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
  <%@page import="com.info.Edit, com.info.EditUser, com.info.Data"%>
  
    	<%
				//HERE WE GETTING THE ATTRIBUTE DECLARED IN VALIDATE.JSP AND CHECKING IF IT IS NULL, THE USER WILL BE REDIRECTED TO LOGIN PAGE
				String uid = (String)session.getAttribute("username");
      			String type = (String)session.getAttribute("type");
				if (session.getAttribute("type").equals("admin")|| uid == null)
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
	          <a class="nav-link" aria-current="page" href="user.jsp">Home</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="form.jsp">Add</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" href="record.jsp">Record</a>
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
				<!-- WE HAVE GIVEN LOGOUT.JSP FILE INORDER TO LOGOUT THE SESSION -->
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
		Data d=Edit.getRecordById(Integer.parseInt(id));  
	%>
	
	<h2 align="center">Edit Data</h2>
	
	<form class="w-25 mx-auto" action="./edit" method="post" enctype="multipart/form-data">
		<div class="container">
		
			<input type=text name="id" value="<%=d.getId() %>" hidden>
			
			<div class="mb-3">
				<label for="education" class="form-label">File</label>
				<input type="file" class="form-control" id="file" name="file">
			</div>
			
			<div class="mb-3">
				<label for="education" class="form-label">Comment</label>
				<textarea class="form-control" id="comment" name="comment"><%=d.getComment() %></textarea>
			</div>
			
			<div class="mb-3">
				<input type="submit" class="btn btn-primary" value="Submit">
				<a href="record.jsp" class="btn btn-danger">Cancel</a>
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