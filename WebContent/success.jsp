<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Booking Confirmation</title>
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

        .confirmation-container {
            max-width: 600px;
            width: 100%;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .confirmation-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .confirmation-header h2 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #212529;
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
    <div class="confirmation-container">
        <div class="confirmation-header">
            <h2>Booking Confirmed!</h2>
            <h4><%= request.getParameter("message") != null ? request.getParameter("message") : "Thank you for booking with VELVETVIBE!" %></h4>
        </div>
        <p>Your booking has been successfully confirmed. Here are the details:</p>
        <ul class="list-group mb-3">
            <li class="list-group-item"><strong>Service:</strong> <%= request.getParameter("serviceName") %></li>
            <li class="list-group-item"><strong>Appointment Date:</strong> <%= request.getParameter("appointmentDate") %></li>
            <li class="list-group-item"><strong>Appointment Time:</strong> <%= request.getParameter("appointmentTime") %></li>
            <li class="list-group-item"><strong>Total Amount:</strong> &#x20B9; <%= request.getParameter("totalAmount") %></li>
        </ul>
        <div class="d-flex justify-content-center">
            <a href="user.jsp" class="btn btn-custom">Go to Home</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
