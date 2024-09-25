<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.ServiceVelvetvibeBean" %>
<%@ page import="dao.ServiceVelvetvibeDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <title>View Services - VELVETVIBE</title>
    <style>
        body {
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 2rem;
        }

        .table-container {
            width: 100%;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 1rem;
        }

        .table thead th {
            background-color: #343a40;
            color: #fff;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .table tbody tr:hover {
            background-color: #e2e6ea;
        }

        .table img {
            max-width: 150px;
            max-height: 150px;
            object-fit: cover;
            border-radius: 5px;
        }

        .btn-custom {
            background-color: #343a40;
            border-color: #343a40;
            color: #fff;
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
        .add-btn {
            margin-bottom: 20px;
            background-color: #495057;
            border-color: #495057;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="table-container">
            <h3>VELVETVIBE</h3>
            <h4 class="text-center">Services Details</h4><br>
            
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
            <a href="addServiceVelvetvibe.jsp" class="btn btn-primary add-btn">Add New</a>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Service ID</th>
                        <th scope="col">Service Name</th>
                        <th scope="col">Category ID</th>
                        <th scope="col">Category Name</th>
                        <th scope="col">Description</th>
                        <th scope="col">Image 1</th>
                        <th scope="col">Image 2</th>
                        <th scope="col">Image 3</th>
                        <th scope="col">Amount From</th>
                        <th scope="col">Amount To</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ServiceVelvetvibeDAO dao = new ServiceVelvetvibeDAO();
                        List<ServiceVelvetvibeBean> services = dao.getAllServiceVelvetvibe1();
                        for (ServiceVelvetvibeBean service : services) {
                    %>
                    <tr>
                        <td><%= service.getServicevv_id() %></td>
                        <td><%= service.getService_id() %></td>
                        <td><%= service.getService_name() %></td>
                        <td><%= service.getCategoryId() %></td>
                        <td><%= service.getCategoryName() %></td>
                        <td><%= service.getDescription() %></td>
                        <td><img alt="Service Image 1" src="<%= service.getImage1() %>"></td>
                        <td><img alt="Service Image 2" src="<%= service.getImage2() %>"></td>
                        <td><img alt="Service Image 3" src="<%= service.getImage3() %>"></td>
                        <td><%= service.getAmount_from() %></td>
                        <td><%= service.getAmount_to() %></td>
                        <td>
                            <a href="editServiceVelvetvibe.jsp?id=<%= service.getServicevv_id() %>" class="btn btn-custom btn-sm">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <a href="deleteServiceVelvetvibe.jsp?id=<%= service.getServicevv_id() %>" class="btn btn-danger btn-sm">
                                <i class="bi bi-trash"></i>
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
