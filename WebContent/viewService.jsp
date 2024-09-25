<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="bean.addServiceBean"%>
<%@ page import="java.util.List"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<title>Service List - VELVETVIBE</title>
<style>
body {
	background-color: #e9ecef;
	font-family: 'Arial', sans-serif;
	color: #333;
}

.container {
	max-width: 800px;
	padding: 2rem;
	margin-top: 50px;
	background-color: #ffffff;
	border-radius: 15px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

h3 {
	font-size: 2rem;
	font-weight: bold;
	color: #212529;
	text-align: center;
}

.table-striped tbody tr:nth-of-type(odd) {
	background-color: rgba(0, 0, 0, 0.05);
}

th, td {
	text-align: center;
	vertical-align: middle;
}

.btn-custom {
	background-color: #343a40;
	border-color: #343a40;
	border-radius: 30px;
	padding: 8px 20px;
	font-size: 1rem;
	font-weight: bold;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: #fff;
	transition: all 0.3s ease;
	margin-bottom: 20px;
}

.btn-custom:hover {
	background-color: #495057;
	border-color: #495057;
}

.action-icons a {
	margin: 0 5px;
}

.action-icons i {
	font-size: 1.2rem;
}
</style>
</head>
<body>
	<div class="container">
		<h3>VELVETVIBE</h3>
		<h4 class="text-center">Service List</h4>
		<a href="addService.jsp" class="btn btn-custom mb-3">Add New
			Service</a>
		<%
			HttpSession httpsession = request.getSession(false); // Retrieve existing session or null if none exists
			String role = null;

			if (httpsession != null) {
				role = (String) httpsession.getAttribute("role");
			}

			if (role == null || !"admin".equals(role)) {
				response.sendRedirect("login.jsp"); // Redirect to login page if not logged in or not an admin
				return;
			}
		%>
		<table class="table table-striped" border="1">
			<thead>
				<tr>
					<th>#</th>
					<th scope="col">Service ID</th>
					<th scope="col">Service Name</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
					// Create an instance of AddServiceDAO
					ServiceDAO serviceDAO = new ServiceDAO();

					// Fetch the list of services
					List<addServiceBean> services = serviceDAO.getAllServices();
					int rowNumber = 1;
					// Iterate over the services and display them
					for (addServiceBean service : services) {
				%>
				<tr>
					<td><%=rowNumber++%></td>
					<td><%=service.getService_id()%></td>
					<td><%=service.getServiceName()%></td>
					<td class="action-icons"><a
						href="editService.jsp?service_id=<%=service.getService_id()%>"
						title="Edit"> <i class="bi bi-pencil-square"
							style="color: #333;"></i>

					</a> <a
						href="deleteService.jsp?service_id=<%=service.getService_id()%>"
						title="Delete"> <i class="bi bi-trash" style="color: red;"></i>
					</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
