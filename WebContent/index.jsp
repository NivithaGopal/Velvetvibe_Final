<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="bean.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <title>VELVETVIBE</title>
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
            object-fit: cover; /* Ensures the image covers the container without distortion */
        }

        /* Navbar Styling */
    .navbar-nav {
        background-color: #f8f9fa; /* Light background for navbar */
        padding: 10px 20px; /* Padding around the nav items */
        border-radius: 5px; /* Rounded corners for navbar */
    }

    .nav-link {
        color: #495057; /* Darker color for links */
        text-decoration: none; /* Remove underline */
        font-weight: 500; /* Slightly bold */
        transition: color 0.3s; /* Smooth transition for hover effect */
    }
.btn-outline-success {
    border-radius: 20px; /* Rounded corners for button */
    color: white; /* White text */
    background-color: black; /* Black background */
    border-color: black; /* Black border */
    transition: background-color 0.3s, color 0.3s; /* Smooth transition */
}

.btn-outline-success:hover {
    background-color: #495057; /* Darker shade on hover */
    color: white; /* White text on hover */
}

   

        .search-input {
            position: relative;
        }

        .search-input input {
            border-radius: 20px; /* Rounded corners for input */
            border: 1px solid #ced4da; /* Border color */
            transition: border-color 0.3s; /* Smooth transition for border */
            padding-right: 2.5rem; /* Add space for the button */
        }

        .search-input input:focus {
            border-color: #80bdff; /* Change border color on focus */
            outline: none; /* Remove default outline */
        }

        /* .btn-outline-success {
            border-radius: 20px; /* Rounded corners for button */
            transition: background-color 0.3s, color 0.3s; /* Smooth transition */
        }

        .btn-outline-success:hover {
            background-color: #28a745; /* Green background on hover */
            color: white; /* White text on hover */
        } */

        /* Footer Styling */
        footer {
            background-color: #343a40; /* Dark background for footer */
            color: white; /* White text */
        }

        footer h5 {
            color: #ffffff; /* Footer heading color */
        }

        footer a {
            color: #ffffff; /* Footer link color */
        }

        footer a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>
    <!-- Navbar Starts -->
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><strong>VELVETVIBE</strong></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="index.jsp">Home</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Services</a>
                        <ul class="dropdown-menu">
                           <%
								ServiceDAO serviceDAO = new ServiceDAO();
								List<addServiceBean> serviceList = serviceDAO.getAllServices();
								for (addServiceBean service : serviceList) {
							%>
							<li><a class="dropdown-item" href=""><%=service.getServiceName()%></a></li>
							<%
								}
							%>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Appointment Booking</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="login.jsp">Browse Services</a></li>
                            <li><a class="dropdown-item" href="login.jsp">Book Appointment</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="feedback.jsp">Feedback</a></li>
                </ul>
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 d-flex align-items-center">
                   <li class="nav-item search-input">
    <form class="d-flex ms-3" role="search" action="searchServices.jsp" method="GET">
        <input class="form-control me-2" type="search" name="query" placeholder="Search...." aria-label="Search">
        <button class="btn" type="submit">
            <i class="fas fa-search" style="color: black;"></i> <!-- Font Awesome Search Icon -->
        </button>
    </form>
</li>

                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">
                            <i class="fas fa-heart"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login/Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Navbar Ends -->

    <!-- Carousel Starts -->
    <div id="carouselExampleIndicators" class="carousel slide">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="./images/vv-img1.jpg" alt="Beauty Image 1">
            </div>
            <div class="carousel-item">
                <img src="./images/vv-img2.jpg" alt="Beauty Image 2">
            </div>
            <div class="carousel-item">
                <img src="./images/vvf-img3.jpg" alt="Beauty Image 3">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
    <!-- Carousel Ends -->

    <!-- About Us Section Starts -->
    <section class="about-us">
        <div class="container">
            <h2>About Us</h2>
            <p>Welcome to VelvetVibe : Your ultimate destination for salon services! We provide an extensive range of services that cater to all your beauty and wellness needs. Our experienced professionals ensure you receive the highest quality of care in a relaxing environment. Experience luxury and convenience with our online booking system.</p>
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
