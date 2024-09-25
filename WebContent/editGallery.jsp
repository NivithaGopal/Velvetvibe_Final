<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="dao.GalleryDAO"%>
<%@ page import="bean.GalleryBean"%>
<%@ page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Edit Gallery - VELVETVIBE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	color: #333;
	font-family: 'Arial', sans-serif;
}

.container {
	max-width: 600px;
	margin-top: 50px;
	background-color: #ffffff;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-group label {
	font-weight: bold;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-primary:hover {
	background-color: #0056b3;
	border-color: #004085;
}
</style>
<script type="text/javascript">
	function validateform() {
		var image1=document.getElementById("image1").value;
		var image2=document.getElementById("image2").value;
		var imagePattern = /\.(jpg|jpeg|png|gif)(\?.*)?$/i; // Matches .jpg, .jpeg, .png, .gif before query parameters
		var bingImagePattern = /OIP\.[a-zA-Z0-9_-]+/; 
		var gstaticImagePattern = /gstatic\.com\/images\?/;
		
		if(image1 == "" && image2 == ""){
			alert("Atleast one Image is Required!");
			document.getElementById("image1").focus();
			document.getElementById("image2").focus();
			return false;
			
		}
		
		if (image1 !== "" && !imagePattern.test(image1) && !bingImagePattern.test(image1) && !gstaticImagePattern.test(image1)) {
			alert("Image 1 is not a valid image URL! Please provide a correct image URL ending with .jpg, .jpeg, .png, or .gif, a valid Bing image URL, or a valid Gstatic image URL.");
			return false;
		}
		if (image2 !== "" && !imagePattern.test(image2) && !bingImagePattern.test(image2) && !gstaticImagePattern.test(image2)) {
			alert("Image 2 is not a valid image URL! Please provide a correct image URL ending with .jpg, .jpeg, .png, or .gif, a valid Bing image URL, or a valid Gstatic image URL.");
			return false;
		}

		return true;
		
	}

</script>
</head>
<body>
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
	<div class="container">
		<h2 class="text-center">Edit Gallery</h2>
		<%
			String galleryId = request.getParameter("galleryId");
			if (galleryId == null || galleryId.isEmpty()) {
				out.println("<p class='text-danger'>Invalid gallery ID.</p>");
			} else {
				try {
					GalleryDAO galleryDAO = new GalleryDAO();
					GalleryBean gallery = galleryDAO.getGalleryById(Integer.parseInt(galleryId));

					if (gallery != null) {
		%>
		<form action="galleryAction.jsp" method="post" onsubmit="return validateform()">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="galleryId" value="<%=gallery.getGalleryId()%>">
			<div class="form-group mb-3">
				<label for="image1">Image 1 Name:</label> <input type="text"
					class="form-control" id="image1" name="image1"
					value="<%=gallery.getImage1()%>" >
			</div>
			<div class="form-group mb-3">
				<label for="image2">Image 2 Name:</label> <input type="text"
					class="form-control" id="image2" name="image2"
					value="<%=gallery.getImage2()%>" >
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn-primary">Update
					Gallery</button>
				<a href="viewGallery.jsp" class="btn btn-secondary">Cancel</a>
			</div>
		</form>

		<%
			} else {
						out.println("<p class='text-danger'>Gallery not found.</p>");
					}
				} catch (SQLException e) {
					e.printStackTrace();
					out.println("<p class='text-danger'>Error fetching gallery details. Please try again later.</p>");
				}
			}
		%>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
