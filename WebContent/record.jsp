<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   

<%@page import="com.info.EditUser, com.info.Data"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hello</title>
    <link
	  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	  rel="stylesheet"
	/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
  
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
  	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
  	
  </head>
  <body>
  
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
			String id=(String)session.getAttribute("id");  
			Data d=EditUser.getRecordById(Integer.parseInt(id)); 
		%>
	
    	<img src="getimageuser.jsp?id=<%=d.getId() %>" width="50px">
		
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
	
	<sql:setDataSource
        var="myDS"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/assignment1"
        user="root" password="root"
    />
     
    <sql:query var="listUsers"   dataSource="${myDS}">
        SELECT * FROM input;
    </sql:query>
     
    <div class="container">
    <caption><h2 align=center>List of data</h2></caption>
        <table class="table table-striped w-50 mx-auto" style="width:100%">            
            <tr>
            	<th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>File</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="user" items="${listUsers.rows}">
                <tr>
                    <td><c:out value="${user.id}" /></td>
                    <td><c:out value="${user.name}" /></td>
                    <td><c:out value="${user.email}" /></td>
                    <td><c:out value="${user.filename}" /></td>
                    <td><a href="editform.jsp?id=${user.id}" class="btn btn-success"><i class="fa-solid fa-pencil"></i></a> |
						<a href="#delete_${user.id}" class="btn btn-danger" data-bs-toggle="modal" ><i class="fa-solid fa-trash"></i></a></td>
                </tr>
                <!-- Modal -->
                <div class="modal fade" id="delete_${user.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Record</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        <form action="./delete" method="post">
							<input type=text name="id" value="${user.id}" hidden>
							<p>are you sure want to delete this record?</p>
							<p>record id : <b>${user.id}</b></p>
						
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
				        <input type="submit" class="btn btn-danger" value="Yes">
				      </div>
				      </form>
				    </div>
				  </div>
				</div>
				<!-- End Modal -->
            </c:forEach>
        </table>
    </div>


    
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