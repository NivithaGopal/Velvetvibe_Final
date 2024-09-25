<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="dao.ServiceCategoryDAO"%>
<%@ page import="bean.ServiceCategoryBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.SQLException"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<title>View Service Categories - VELVETVIBE</title>
<style>
body {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background-color: #e9ecef;
	font-family: 'Arial', sans-serif;
	color: #333;
}

.container {
	max-width: 1200px;
	width: 100%;
	padding: 2rem;
}

.table-container {
	background-color: #ffffff;
	border-radius: 15px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	padding: 1rem;
}

.table td, .table th {
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

h3 {
	font-size: 2rem;
	font-weight: bold;
	color: #212529;
	text-align: center;
}

.action-icons a {
	margin: 0 5px;
}

.action-icons i {
	font-size: 1.2rem;
}

.action-column {
	width: 150px; /* Adjust the width as needed */
	text-align: center; /* Center align the content */
}
</style>
</head>
<body>
	<div class="container">
		<div class="table-container">
			<h3>VELVETVIBE</h3>
			<h4 class="text-center">Service Categories</h4>
			<br>
			<div class="d-flex justify-content-start">
				<a href="addServiceCategory.jsp" class="btn btn-custom">Add New
					Category</a>
			</div>
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
						<th scope="col">Category ID</th>
						<th scope="col">Category Name</th>
						<th scope="col">Service Name</th>
						<th scope="col">Service Price</th>
						<th scope="col">Description</th>
						<th scope="col" class="action-column">Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
						ServiceCategoryDAO categoryDAO = new ServiceCategoryDAO();
						List<ServiceCategoryBean> categories = null;
						int rowNumber = 1;
						try {
							categories = categoryDAO.getAllCategoriesWithServiceNames();
						} catch (SQLException e) {
							e.printStackTrace();
						}

						if (categories != null && !categories.isEmpty()) {
							for (ServiceCategoryBean category : categories) {
					%>
					<tr>
						<td><%=rowNumber++%></td>
						<td><%=category.getCategoryId()%></td>
						<td><%=category.getCategoryName()%></td>
						<td><%=category.getServiceName()%></td>
						<td><%=category.getServicePrice()%></td>
						<td><%=category.getServiceDescription()%></td>
						<td class="action-icons"><a
							href="editServiceCategory.jsp?service_id=<%=category.getCategoryId()%>"
							title="Edit"> <i class="bi bi-pencil-square"
								style="color: #333;"></i>
						</a> <a href="#"
							onclick="confirmDelete('<%=category.getCategoryId()%>'); return false;"
							title="Delete"> <i class="bi bi-trash" style="color: red;"></i>
						</a></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td colspan="7" class="text-center">No categories found.</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function confirmDelete(categoryId) {
			if (confirm('Are you sure you want to delete this category?')) {
				window.location.href = 'deleteServiceCategory.jsp?service_id='
						+ categoryId;
			}
		}
	</script>
</body>
</html>
