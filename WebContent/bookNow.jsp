<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="dao.*" %>
<%@ page import="bean.*" %>



<%
    HttpSession httpsession = request.getSession(false);
    String email = null;

    // Retrieve the email from the session
    if (httpsession != null) {
        email = (String) httpsession.getAttribute("email");
    }

    // Redirect to login if session does not exist or email is not found
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch user details from the database
    UserProfileDAO userDAO = new UserProfileDAO();
    UserProfileBean user = userDAO.getUserByEmail(email);

    if (user == null) {
        response.sendRedirect("login.jsp?message=User not found");
        return;
    }
%>
<%
    // Retrieve service details from the request
    String serviceId = request.getParameter("serviceId");
    String serviceName = request.getParameter("serviceName");
    String amountFrom = request.getParameter("amountFrom");
    String amountTo = request.getParameter("amountTo");

    if (serviceId == null || serviceName == null || amountFrom == null || amountTo == null) {
        response.sendRedirect("getservicesuser.jsp?message=Invalid service details");
        return;
    }

    // Calculate total amount (for simplicity, let's just pick the middle value between amountFrom and amountTo)
    double totalAmount = (Double.parseDouble(amountFrom) + Double.parseDouble(amountTo)) / 2;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <title>Schedule Booking - VELVETVIBE</title>
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

        .booking-container {
            max-width: 600px;
            width: 100%;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .booking-header {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .booking-header h2 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #212529;
        }

        .btn-custom {
            width: 100%;
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

        .form-control, .form-select {
            border-radius: 10px;
            padding: 15px;
            font-size: 1rem;
            background: #f8f9fa;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
            border: 1px solid #ced4da;
        }
    </style>
    
    <script type="text/javascript">
        function validateform() {
            var appointmentDate = document.getElementById("appointmentDate").value;
            var appointmentTime = document.getElementById("appointmentTime").value;

            if (appointmentDate == "") {
                alert("Select appointment date!");
                document.getElementById("appointmentDate").focus();
                return false;
            }

            if (appointmentTime == "") {
                alert("Select appointment time!");
                document.getElementById("appointmentTime").focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="booking-container">
        <div class="booking-header">
            <h2>VELVETVIBE</h2>
            <h4>Schedule Booking for <%= serviceName %></h4>
        </div>
        <form action="confirmBooking.jsp" method="POST" onsubmit="return validateform()" id="checkoutForm">
            <input type="hidden" name="serviceId" value="<%= serviceId %>">
            <input type="hidden" name="amountFrom" value="<%= amountFrom %>">
            <input type="hidden" name="amountTo" value="<%= amountTo %>">
            <input type="hidden" name="serviceName" value="<%= serviceName %>">
            <input type="hidden" name="razorpay_payment_id" id="razorpay_payment_id">

            <div class="mb-3">
                <label for="serviceName" class="form-label">Service Name</label>
                <input type="text" class="form-control" id="serviceName" value="<%= serviceName %>" readonly>
            </div>

            <div class="mb-3">
                <label for="amountRange" class="form-label">Amount Range</label>
                <input type="text" class="form-control" id="amountRange" value="&#x20B9; <%= amountFrom %> - &#x20B9; <%= amountTo %>" readonly>
            </div>

            <div class="mb-3">
                <label for="appointmentDate" class="form-label">Choose Appointment Date</label>
                <input type="date" class="form-control" id="appointmentDate" name="appointmentDate" >
            </div>

            <div class="mb-3">
                <label for="appointmentTime" class="form-label">Choose Appointment Time</label>
                <select class="form-select" id="appointmentTime" name="appointmentTime">
                    <!-- Time slots will be dynamically added here -->
                </select>
            </div>

            <div class="mb-3">
                <label for="totalAmount" class="form-label">Total Amount</label>
                <input type="text" class="form-control" id="totalAmount" value="&#x20B9; <%= totalAmount %>" readonly>
            </div>

            <div class="d-flex justify-content-center mt-3">
                <button type="button" class="btn btn-custom" id="payBtn">Pay Now</button>
            </div>
        </form>
    </div>

    <script>
        // Restrict past dates
        window.onload = function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("appointmentDate").setAttribute('min', today);
            populateTimeSlots(); // Populate time slots when page loads
        };

        // Populate time slots from 9:00 AM to 1:00 PM and 2:00 PM to 6:00 PM with 30-minute intervals
        function populateTimeSlots() {
            var timeSelect = document.getElementById("appointmentTime");

            var times = [
                "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM",
                "02:00 PM", "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM", "05:30 PM", "06:00 PM"
            ];

            times.forEach(function(time) {
                var option = document.createElement("option");
                option.value = time;
                option.text = time;
                timeSelect.appendChild(option);
            });
        }

        // Razorpay payment integration
        document.getElementById('payBtn').onclick = function(e) {
            e.preventDefault();

            var options = {
                "key": "rzp_test_3FiYqdcHdWq0a2", // Enter the Key ID generated from the Razorpay Dashboard
                "amount": "<%= (int)(totalAmount * 100) %>", // Razorpay expects the amount in paise
                "currency": "INR",
                "name": "VELVETVIBE",
                "description": "Service Booking Payment",
                "handler": function (response){
                    // This function handles the payment response
                    document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
                    document.getElementById('checkoutForm').submit(); // Submit the form after payment success
                },
                "prefill": {
                    "email": "<%= email %>" // Prefill the user's email in Razorpay payment form
                },
                "theme": {
                    "color": "#F37254"
                }
            };
            var rzp1 = new Razorpay(options);
            rzp1.open();
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script> <!-- Razorpay Checkout Script -->
</body>
</html>
