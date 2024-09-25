<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="bean.addServiceBean"%>
<%@ page import="bean.ServiceVelvetvibeBean"%>
<%@ page import="dao.ServiceVelvetvibeDAO"%>

<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>User Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* Remove underline from footer links */
footer a {
	text-decoration: none;
}

/* About Us Section Styling */
.about-us {
	padding: 60px 0;
	background-color: #f8f9fa; /* Light gray background */
}

.about-us h2 {
	color: #333; /* Darker text color */
	font-size: 2.5rem;
	margin-bottom: 20px;
}

.about-us p {
	font-size: 1.125rem;
	color: #555; /* Darker gray text for readability */
	line-height: 1.6;
}

/* Carousel Image Styling */
.carousel-item img {
	width: 100%;
	height: 600px;
	object-fit: cover;
	/* Ensures the image covers the container without distortion */
}

/* Search Input Styling */
.search-input {
	position: relative;
}

.search-input input {
	padding-right: 2.5rem; /* Add space for the icon */
}

.search-input .fa-search {
	position: absolute;
	right: 0.5rem;
	top: 50%;
	transform: translateY(-50%);
	color: #6c757d;
	padding: 20px;
}
</style>
</head>
<body>
	<!-- Navbar Starts  -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"><strong>VELVETVIBE</strong></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Services </a>
						<ul class="dropdown-menu">
							<%
								ServiceDAO dao = new ServiceDAO();
								List<addServiceBean> services = dao.getAllServices();
								if (services != null && !services.isEmpty()) {
									for (addServiceBean service : services) {
							%>
							<li><a class="dropdown-item"
								href="getservcesuser.jsp?serviceId=<%=service.getService_id()%>">
									<%=service.getServiceName()%>
							</a></li>
							<%
								}
								} else {
							%>
							<li><a class="dropdown-item" href="#">No services
									available</a></li>
							<%
								}
							%>
						</ul></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">Appointment
							Booking</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="viewBooking.jsp">Book Appointment</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link " href="feedback.jsp">Feedback</a></li>
										<li class="nav-item"><a class="nav-link " href="viewGalleryUser.jsp">Gallery</a></li>
					
				</ul>
				<ul
					class="navbar-nav ms-auto mb-2 mb-lg-0 d-flex align-items-center">
										<li class="nav-item"><a class="nav-link" href="viewFavourites.jsp"> <i
							class="fas fa-heart"></i></a></li>
					<li class="nav-item"><a class="nav-link"
						href="userProfile.jsp"> <i class="fas fa-user"></i>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="logout.jsp">
							<i class="fas fa-sign-out-alt"></i>
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Navbar Ends  -->
	<%
		HttpSession httpsession = request.getSession(false); // Retrieve existing session or null if none exists
		String email = null;

		if (httpsession != null) {
			email = (String) httpsession.getAttribute("email");
		}

		if (email == null) {
			response.sendRedirect("login.jsp"); // Redirect to login page if not logged in or not an admin
			return;
		}
	%>

<br>

	<%
		ServiceVelvetvibeDAO dao2 = new ServiceVelvetvibeDAO();
		List<ServiceVelvetvibeBean> services2 = dao2.getAllServiceVelvetvibe();
	%>




	<div class="container">
		<div class="row">
			<%
				for (ServiceVelvetvibeBean service : services2) {
			%>
			<div class="col-md-4">
				<div class="card mb-4 shadow-sm"
					style="width: 400px; height: 700px;">
					<img src="<%=service.getImage1()%>" class="card-img-top"
						alt="<%=service.getService_name()%> Image"
						style="height: 400px; object-fit: cover;">
					<div class="card-body" style="overflow-y: auto;">
						<h5 class="card-title"><%=service.getService_name()%></h5>
						<h6 class="card-subtitle mb-2 text-muted"><%=service.getCategoryName()%></h6>
						<p class="card-text">
							<%
								String description = service.getDescription();
									if (description.length() > 100) {
										description = description.substring(0, 200) + "...";
									}
							%>
							<%=description%>
						</p>


						<p class="card-text">
							Price Range:  &#8377;<%=service.getAmount_from()%>
							-  &#8377;<%=service.getAmount_to()%>
						</p>
					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
	</div>



	<!-- About Us Section Starts -->
	<section class="about-us">
		<div class="container">
			<h2>About Us</h2>
			<p>Welcome to VelvetVibe : Your Premier Beauty Booking
				Destination</p>
			<p>At VelvetVibe, we are dedicated to simplifying your beauty
				experience by offering a seamless, online platform for booking
				top-notch salon services. Our goal is to connect you with the best
				beauty professionals, ensuring you receive exceptional service and
				stunning results every time.</p>
		</div>
	</section>
	<!-- About Us Section Ends -->
	<!-- Footer Starts  -->
	<footer class="bg-dark text-white pt-5 pb-3">
		<div class="container">
			<div class="row">
				<!-- Company Information -->
				<div class="col-md-3">
					<h5 class="text-uppercase">VELVETVIBE</h5>
					<ul class="list-unstyled">
						<li><a href="#" class="text-white">About Us</a></li>
					</ul>
				</div>

				<!-- Customer Service -->
				<div class="col-md-3">
					<h5 class="text-uppercase">Customer Service</h5>
					<ul class="list-unstyled">
						<li><a href="#" class="text-white">Contact Us</a></li>
					</ul>
				</div>

				<!-- Social Media Links -->
				<div class="col-md-3">
					<h5 class="text-uppercase">Follow Us</h5>
					<ul class="list-unstyled d-flex">
						<li class="me-3"><a href="#" class="text-white"><i
								class="fab fa-facebook-f"></i> Facebook</a></li>
						<li class="me-3"><a href="#" class="text-white"><i
								class="fab fa-twitter"></i> Twitter</a></li>
						<li class="me-3"><a href="#" class="text-white"><i
								class="fab fa-instagram"></i> Instagram</a></li>
						<li><a href="#" class="text-white"><i
								class="fab fa-youtube"></i> YouTube</a></li>
					</ul>
				</div>
			</div>

			<div class="text-center mt-4">
				<p class="mb-0">&copy; 2024 VELVETVIBE. All rights reserved.</p>
			</div>
		</div>
	</footer>
	<!-- Footer Ends -->
</body>
</html>