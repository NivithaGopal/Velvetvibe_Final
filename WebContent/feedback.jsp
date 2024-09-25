<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>VELVETVIBE - Customer Feedback</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
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
/* Style for feedback form */
.feedback-input {
	border-radius: 10px;
	border: 1px solid #ced4da;
	padding: 15px;
	font-size: 1rem;
	background: #e9ecef;
	box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
}

.form-label {
	font-weight: bold;
	color: #495057;
	margin-bottom: 10px;
}

.btn-save {
	background-color: #343a40;
	border-color: #343a40;
	border-radius: 30px;
	padding: 10px 20px;
	font-size: 1.2rem;
	font-weight: bold;
	text-transform: uppercase;
	letter-spacing: 1px;
	transition: all 0.3s ease;
	color: #fff;
}

.btn-save:hover {
	background-color: #495057;
	border-color: #495057;
}
</style>
<script type="text/javascript">

function formvalidation() {
	
	var email = document.getElementById("email").value;
	var comments = document.getElementById("comments").value;
	var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	var minCommentLength = 10; // Minimum number of characters required for comments
	if (email == "") {
		alert("Email required");
		document.getElementById("email").focus();
		return false;
	}if (!emailPattern.test(email)) {
		alert("Please enter a valid email address.");
		document.getElementById("email").focus();
		return false;
	}
	if (comments == "") {
		alert("Comments required");
		document.getElementById("comments").focus();
		return false;
	}
	if (comments.length < minCommentLength) {
		alert("Comments must be at least " + minCommentLength
				+ " characters long.");
		document.getElementById("comments").focus();
		return false;
	}

	return true;

}

</script>
</head>
<body>

	<!-- Navbar Starts  -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<!-- Center the brand name -->
			<div class="mx-auto">
				<h3><strong>VELVETVIBE</strong></h3>
			</div>
			
		</div>
	</nav>
	<!-- Navbar Ends  -->
	<div class="container mt-5">
		<h4 class="mb-4 text-center">Customer Feedback</h4>
		<form action="feedbackAction.jsp" method="post" onsubmit="return formvalidation()">
			<!-- Email -->
			<div class="mb-3">
				<label for="email" class="form-label">Email Address</label> <input
					type="email" class="form-control feedback-input" id="email"
					placeholder="Enter your email" name="email" >
			</div>
			<!-- Comments -->
			<div class="mb-3">
				<label for="comments" class="form-label">Your Comments</label>
				<textarea class="form-control feedback-input" id="comments"
					name="comments" rows="4" placeholder="Enter your comments" ></textarea>
			</div>
			<!-- Save Button -->
			<button type="submit" class="btn btn-primary btn-save">Save</button>
		</form>
	</div>

	<!-- About Us Section Starts -->
	<section class="about-us">
        <div class="container">
            <h2>About Us</h2>
            <p>Welcome to VelvetVibe : Your Premier Beauty Booking Destination</p>
            <p>At VelvetVibe, we are dedicated to simplifying your beauty experience by offering a seamless, online platform for booking top-notch salon services. Our goal is to connect you with the best beauty professionals, ensuring you receive exceptional service and stunning results every time.</p>
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
	
	<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>
