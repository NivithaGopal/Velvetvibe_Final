<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO" %>
<%@ page import="bean.addServiceBean" %>
<%@ page import="java.util.List" %>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<title>Add Service - VELVETVIBE</title>
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

.service-container {
	max-width: 500px;
	width: 100%;
	padding: 2rem;
	background-color: #ffffff;
	border-radius: 15px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.service-header {
	text-align: center;
	margin-bottom: 1.5rem;
	color: #333;
}

.service-header h3 {
	font-size: 1.8rem;
	font-weight: bold;
	color: #212529;
}

.btn-custom {
	width: 100%;
	background-color: #343a40;
	border-color: #343a40;
	border-radius: 30px;
	padding: 10px 20px;
	font-size: 1.2rem;
	font-weight: bold;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: #fff;
	transition: all 0.3s ease;
}

.btn-custom:hover {
	background-color: #495057;
	border-color: #495057;
}

.form-label {
	font-weight: bold;
	color: #495057;
}

.form-control, .form-select {
	border-radius: 10px;
	padding: 15px;
	font-size: 1rem;
	background: #f8f9fa;
	box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
	border: 1px solid #ced4da;
}

.text-muted {
	color: #6c757d !important;
}
</style>

<script type="text/javascript">
function validatForm() {
	var categoryName = document.getElementById("categoryName").value.trim();
	var serviceCategory = document.getElementById("serviceCategory").value.trim();
	var servicePrice = document.getElementById("servicePrice").value.trim();
	var serviceDescription = document.getElementById("serviceDescription").value.trim();
	
	var nameRegex = /^[a-zA-Z\s]+$/; // Only letters and spaces
    var priceRegex = /^[1-9]\d*(\.\d{1,2})?$/; // Positive numbers with optional decimal, up to 2 decimal places
	
	if (categoryName === "") {
		alert("Category Name is required.");
		document.getElementById("categoryName").focus();
		return false;
	}
	if (!nameRegex.test(categoryName)) {
		alert("Category Name can only contain letters and spaces.");
        document.getElementById("categoryName").focus();
        return false;
	}
	
	if (serviceCategory === "") {
		alert("Please select a service.");
		document.getElementById("serviceCategory").focus();
		return false;
	}
	if (servicePrice === "") {
		alert("Service Price is required.");
		document.getElementById("servicePrice").focus();
		return false;
	}
	if (!priceRegex.test(servicePrice)) {
		alert("Service Price must be a positive number with up to 2 decimal places.");
        document.getElementById("servicePrice").focus();
        return false;
	}
	if (serviceDescription === "") {
		alert("Service Description is required.");	
		document.getElementById("serviceDescription").focus();
		return false;
	}
	
	return true;
}
</script>
</head>
<body>
	<div class="service-container">
		<div class="service-header">
			<h3>VELVETVIBE</h3>
			<p class="text-muted">Add New Salon Category</p>
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
		</div>
		<form action="addServiceCategoryAction.jsp" method="post" onsubmit="return validatForm()">
			<div class="mb-3">
				<label for="categoryName" class="form-label">Category Name</label>
				<input type="text" class="form-control" id="categoryName" name="categoryName" >
			</div>
			<div class="mb-3">
				<label for="serviceCategory" class="form-label">Services</label>
				<select class="form-select" id="serviceCategory" name="serviceCategory" >
					<%
					    ServiceDAO dao = new ServiceDAO();
					    List<addServiceBean> services = dao.getAllServices();
					    if (services != null && !services.isEmpty()) {
					        for (addServiceBean service : services) {
					%>
					    <option value="<%= service.getService_id() %>"><%= service.getServiceName() %></option>
					<%
					        }
					    } else {
					%>
					    <option value="">No services available</option>
					<%
					    }
					%>
				</select>
			</div> 
			<div class="mb-3">
				<label for="servicePrice" class="form-label">Price (&#x20b9)</label>
				<input type="number" class="form-control" id="servicePrice" name="servicePrice" step="0.01" >
			</div>
			<div class="mb-3">
				<label for="serviceDescription" class="form-label">Description</label>
				<textarea class="form-control" id="serviceDescription" name="serviceDescription" rows="4" ></textarea>
			</div>
			<div class="d-flex justify-content-center mt-3">
				<button type="submit" class="btn btn-custom">Add Category</button>
			</div>
		</form>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
