<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.feedbackBean" %>
<%@ page import="dao.feedbackDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Feedback - VELVETVIBE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .navbar {
            margin-bottom: 20px;
            background-color: #f1f1f1; /* Light gray color */
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
            color: #333; /* Darker text color for contrast */
        }

        .navbar-nav .nav-link {
            font-size: 1.1rem;
            font-weight: 500;
            color: #333; /* Darker text color for contrast */
        }

        .navbar-nav .nav-link:hover {
            color: #495057; /* Slightly darker on hover */
        }

        .dropdown-menu {
            min-width: 180px;
        }

        .feedback-table th, .feedback-table td {
            text-align: center;
        }

        .feedback-table {
            margin-top: 20px;
        }

        .welcome-message {
            text-align: center;
            margin-top: 20px;
        }

        h4 {
            text-align: center;
            margin-top: 50px;
            font-size: 2rem;
            font-weight: bold;
            color: #212529;
        }

        .card {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .card-services {
            background-color: gray; /* Match card color with navbar */
            color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .card-body {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            padding: 20px;
        }

        .card-body img {
            border-radius: 50%; /* Makes the image circular */
            max-width: 100px;
            height: auto;
            margin-right: 20px; /* Increased margin for spacing */
        }

        .card-body .text-content {
            flex: 1;
        }

        .card-body .card-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #f8f9fa;
            margin-bottom: 10px; /* Adds spacing between title and content */
        }

        .card-body p {
            font-size: 1.25rem;
            margin: 0;
        }
        
        
    </style>
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

    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><strong>VELVETVIBE</strong></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="servicesDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Services
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="servicesDropdown">
                            <li><a class="dropdown-item" href="addService.jsp">Add New Service</a></li>
                            <li><a class="dropdown-item" href="viewService.jsp">View Services</a></li>
                            <li><a class="dropdown-item" href="addServiceCategory.jsp">Add Service Category</a></li>
                            <li><a class="dropdown-item" href="viewServiceCategory.jsp">View Service Category</a></li>
                        </ul>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Appointments</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Customers</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="viewGallery.jsp">Gallery</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="viewFeedback.jsp">Customer Feedback</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Log Out</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">       
        <h4 class="mb-4">View Customer Feedback</h4>
        
        <table class="table table-striped feedback-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Comments</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    feedbackDAO feedbackDAO = new feedbackDAO();
                    List<feedbackBean> feedbackList = feedbackDAO.getAllFeedback();
                    for (feedbackBean feedback : feedbackList) { 
                %>
                <tr>
                    <td><%= feedback.getFeedback_id() %></td>
                    <td><%= feedback.getEmail() %></td>
                    <td><%= feedback.getComments() %></td>
                    <td><%= feedback.getCreated_at() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Back Button -->
        <div class="text-center mt-4">
            <a href="admin.jsp" class="btn btn-secondary">Back</a>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
