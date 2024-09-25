<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="dao.ServiceCategoryDAO"%>
<%@ page import="bean.addServiceBean" %>
<%@ page import="bean.ServiceCategoryBean" %>

<!DOCTYPE html>
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
	max-width: 600px;
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

.service-header h2 {
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
	function validateform() {
		var serviceName=document.getElementById("serviceName").value;
		var categoryName=document.getElementById("categoryName").value;
		var description=document.getElementById("description").value;
		var image1=document.getElementById("image1").value;
		var image2=document.getElementById("image2").value;
		var image3=document.getElementById("image3").value;
		var amountFrom=document.getElementById("amountFrom").value;
		var amountTo=document.getElementById("amountTo").value;
		
		/* var imagePattern = /\.(jpg|jpeg|png|gif)(\?.*)?$/i; // Matches .jpg, .jpeg, .png, .gif before query parameters
		var bingImagePattern = /OIP\.[a-zA-Z0-9_-]+/;
		var priceRegex = /^[1-9]\d*(\.\d{1,2})?$/; 
		var gstaticImagePattern = /gstatic\.com\/images\?/; */
		
		if(serviceName == ""){
			alert("ServiceName is required!");
			document.getElementById("serviceName").focus();
			return false;
		}
		if(categoryName == ""){
			alert("Category Name is required!");
			document.getElementById("categoryName").focus();
			return false;
		}
		if(description == ""){
			alert("Description is required!");
			document.getElementById("description").focus();
			return false;
		}
		if(image1 == "" && image2 == "" && image3 == ""){
			alert("Atleast one image is required!");
			document.getElementById("image1").focus();
			return false;
		}
		
		/* if (image1 !== "" && !imagePattern.test(image1) && !bingImagePattern.test(image1) && !gstaticImagePattern.test(image1)) {
			alert("Image 1 is not a valid image URL! Please provide a correct image URL ending with .jpg, .jpeg, .png, or .gif, a valid Bing image URL, or a valid Gstatic image URL.");
			return false;
		}
		if (image2 !== "" && !imagePattern.test(image2) && !bingImagePattern.test(image2) && !gstaticImagePattern.test(image2)) {
			alert("Image 2 is not a valid image URL! Please provide a correct image URL ending with .jpg, .jpeg, .png, or .gif, a valid Bing image URL, or a valid Gstatic image URL.");
			return false;
		}
		if (image3 !== "" && !imagePattern.test(image3) && !bingImagePattern.test(image3) && !gstaticImagePattern.test(image3)) {
			alert("Image 3 is not a valid image URL! Please provide a correct image URL ending with .jpg, .jpeg, .png, or .gif, a valid Bing image URL, or a valid Gstatic image URL.");
			return false;
		} */
		
		
		if(amountFrom == ""){
			alert("Amount range is required!");
			document.getElementById("amountFrom").focus();
			return false;
		}
		if (!priceRegex.test(amountFrom)) {
			alert("Amount From must be a positive number with up to 2 decimal places.");
	        document.getElementById("amountFrom").focus();
	        return false;
		}
		if(amountTo == ""){
			alert("Amount To is required!");
			document.getElementById("amountTo").focus();
			return false;
		}
		if (!priceRegex.test(amountTo)) {
			alert("Amount To must be a positive number with up to 2 decimal places.");
	        document.getElementById("amountTo").focus();
	        return false;
		}
		
		return true;
	}

</script>
</head>
<body>
	<div class="service-container">
		<div class="service-header">
			<h2>VELVETVIBE</h2>
			<p class="text-muted">Add New Service</p>
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
		<form action="addServiceVelvetvibeAction.jsp" method="post" onsubmit="return validateform()">
			<div class="mb-3">
				<label for="serviceName" class="form-label">Service Name</label>
				<select class="form-select" id="serviceName" name="service_id" >
					<%
						ServiceDAO serviceDAO = new ServiceDAO();
						List<addServiceBean> services = serviceDAO.getAllServices();
						for (addServiceBean service : services) {
					%>
					<option value="<%=service.getService_id()%>"><%=service.getServiceName()%></option>
					<%
						}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label for="categoryName" class="form-label">Category Name</label>
				<select class="form-select" id="categoryName" name="categoryId" >
    <%
        ServiceCategoryDAO categoryDAO = new ServiceCategoryDAO();
        List<ServiceCategoryBean> categories = categoryDAO.getAllCategories();
        for (ServiceCategoryBean category : categories) {
    %>
        <option value="<%=category.getCategoryId()%>"><%=category.getCategoryName()%></option>
    <%
        }
    %>
</select>

			</div>
			<div class="mb-3">
				<label for="description" class="form-label">Description</label>
				<textarea class="form-control" id="description" name="description" rows="4" ></textarea>
			</div>
			<div class="mb-3">
				<label for="image1" class="form-label">Image 1</label>
				<input type="text" class="form-control" id="image1" name="image1" >
			</div>
			<div class="mb-3">
				<label for="image2" class="form-label">Image 2</label>
				<input type="text" class="form-control" id="image2" name="image2">
			</div>
			<div class="mb-3">
				<label for="image3" class="form-label">Image 3</label>
				<input type="text" class="form-control" id="image3" name="image3">
			</div>
			<div class="mb-3">
				<label for="amountFrom" class="form-label">Amount From</label>
				<input type="number" class="form-control" id="amountFrom" name="amount_from" step="0.01" >
			</div>
			<div class="mb-3">
				<label for="amountTo" class="form-label">Amount To</label>
				<input type="number" class="form-control" id="amountTo" name="amount_to" step="0.01" >
			</div>
			<div class="d-flex justify-content-center mt-3">
				<button type="submit" class="btn btn-custom">Save</button>
			</div>
		</form>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
