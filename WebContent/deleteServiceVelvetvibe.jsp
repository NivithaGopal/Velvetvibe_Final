<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceVelvetvibeDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Delete Service - VELVETVIBE</title>
    <style>
        body {
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 2rem;
        }
        .alert {
            margin-top: 1rem;
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
    </style>
</head>
<body>
    <div class="container">
        <%
        
        HttpSession httpsession = request.getSession(false); // Retrieve existing session or null if none exists
        String role = null;

        // Check if the session is valid and retrieve the user role
        if (httpsession != null) {
            role = (String) httpsession.getAttribute("role");
        }

        // Redirect to login page if not logged in or not an admin
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                try {
                    ServiceVelvetvibeDAO dao = new ServiceVelvetvibeDAO();
                    boolean isDeleted = dao.deleteServiceVelvetvibe(Integer.parseInt(id));

                    if (isDeleted) {
                        out.println("<div class='alert alert-success' role='alert'>Service deleted successfully.</div>");
                        response.setHeader("Refresh", "2; URL=viewServiceVelvetvibe.jsp");
                    } else {
                        out.println("<div class='alert alert-danger' role='alert'>Failed to delete the service. Please try again.</div>");
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger' role='alert'>An error occurred: " + e.getMessage() + "</div>");
                }
            } else {
                out.println("<div class='alert alert-warning' role='alert'>Invalid service ID.</div>");
            }
        %>
        <a href="viewServiceVelvetvibe.jsp" class="btn btn-custom">Back to Services</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
