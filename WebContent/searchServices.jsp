<%@ page import="java.sql.*, bean.*, dao.*" %>
<%@ page import="java.util.List" %>

<%
    String query = request.getParameter("query");
    List<ServiceVelvetvibeBean> services = null;

    if (query != null && !query.trim().isEmpty()) {
        ServiceVelvetvibeDAO serviceDAO = new ServiceVelvetvibeDAO();
        services = serviceDAO.searchServices(query.trim());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Arial', sans-serif;
            color: #333;
            padding: 5rem 0;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            font-weight: bold;
        }
         h4 {
            text-align: center;}
        .service-card {
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            background: #ffffff;
            margin-bottom: 20px;
        }
        .service-card-header {
            background: linear-gradient(135deg, #6c757d 0%, #343a40 100%);
            color: #fff;
            text-align: center;
            padding: 15px;
            font-size: 1.5rem;
            font-weight: bold;
        }
        .service-card-body {
            padding: 20px;
        }
        .price {
            font-weight: bold;
            color: #28a745;
        }
        .description {
            color: #555;
        }
        .no-results {
            color: #dc3545;
            text-align: center;
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
<h2>VELVETVIBE</h2>
 <h4>Search Results for "<%= query %>"</h4>

<% if (services != null && !services.isEmpty()) { %>
    <div class="container">
        <% for (ServiceVelvetvibeBean service : services) { %>
            <div class="card service-card">
                <div class="service-card-header">
                    <%= service.getService_name() %> <small>(Category: <%= service.getCategoryName() %>)</small>
                </div>
                <div class="service-card-body">
                    <p class="price">Price: &#x20B9; <%= service.getAmount_from() %> - &#x20B9; <%= service.getAmount_to() %></p>
                    <p class="description">Description: <%= service.getDescription() %></p>
                </div>
            </div>
        <% } %>
    </div>
<% } else { %>
    <p class="no-results">No services found matching your search.</p>
<% } %>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
