<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.BookingDAO, bean.BookingBean, java.util.List" %>
<%
    BookingDAO bookingDAO = new BookingDAO();
    List<BookingBean> bookings = bookingDAO.getAllBookings(); // You need to implement this method

    if (bookings == null || bookings.isEmpty()) {
%>
    <html>
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f0f0f0; /* Light gray background */
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                font-family: 'Arial', sans-serif;
            }
            .alert {
                text-align: center;
                color: #333; /* Dark gray text */
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="alert alert-warning" role="alert">No bookings found.</div>
        </div>
    </body>
    </html>
<%
        return; // Exit if no bookings found
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>All Appointments - VELVETVIBE</title>
    <style>
        body {
            background-color: #f0f0f0; /* Light gray background */
            font-family: 'Arial', sans-serif;
        }
        .header {
            text-align: center;
            margin-top: 30px;
            color: #212529; /* Dark gray text */
        }
        .card {
            border: 1px solid #333; /* Black border */
            border-radius: 8px;
            margin-bottom: 1rem;
            background-color: #fff; /* White background */
            transition: transform 0.2s;
        }
        .card:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* Shadow on hover */
        }
        .card-body {
            padding: 1.5rem;
            color: #333; /* Dark gray text */
        }
        .card-title {
            font-weight: bold;
            color: #000; /* Black for emphasis */
        }
        .text-muted {
            color: #888; /* Medium gray text for secondary info */
        }
        h3 {
	font-size: 2rem;
	font-weight: bold;
	color: #212529;
	text-align: center;
}
    </style>
</head>
<body>
    <div class="container">
        <h3 class="header">VELVETVIBE</h3>
        <h4 class="header">All Appointment Details</h4><br>
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
        
        <div class="row">
            <%
                for (BookingBean booking : bookings) {
            %>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Booking ID: <%= booking.getBookingId() %></h5>
                            <p class="card-text"><strong>Service Name:</strong> <%= booking.getServiceName() %></p>
                            <p class="card-text"><strong>Amount Range:</strong> &#x20B9; <%= booking.getAmountFrom() %> - &#x20B9; <%= booking.getAmountTo() %></p>
                            <p class="card-text"><strong>Appointment Date:</strong> <span class="text-muted"><%= booking.getAppointmentDate() %></span></p>
                            <p class="card-text"><strong>Appointment Time:</strong> <span class="text-muted"><%= booking.getAppointmentTime() %></span></p>
                            <p class="card-text"><strong>User Email:</strong> <span class="text-muted"><%= booking.getUserEmail() %></span></p>
                            <p class="card-text"><strong>Payment ID:</strong> <span class="text-muted"><%= booking.getPaymentId() %></span></p>
                        </div>
                    </div>
                </div>
            <%
                }
            %>
        </div>
        
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
