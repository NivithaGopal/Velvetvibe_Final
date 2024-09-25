<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Error - Booking Failed</title>
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

        .error-container {
            max-width: 600px;
            width: 100%;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .error-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .error-header h2 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #dc3545; /* Bootstrap danger color */
        }

        .btn-custom {
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
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-header">
            <h2>Booking Failed!</h2>
            <h4><%= request.getParameter("message") != null ? request.getParameter("message") : "An unexpected error occurred. Please try again." %></h4>
        </div>
        <p>We're sorry, but there was an issue with your booking. Please check the details and try again.</p>
        <div class="d-flex justify-content-center">
            <a href="getservicesuser.jsp" class="btn btn-custom">Back to Services</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
