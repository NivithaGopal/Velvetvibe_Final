<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>

<%

String bookingId=request.getParameter("bookingId");
HttpSession httpsession = request.getSession(false);
String email = null;

if (httpsession != null) {
    email = (String) httpsession.getAttribute("email");
}

if (email == null) {
    response.sendRedirect("login.jsp");
    return;
}


%>
    <script>
        var options = {
            "key": "rzp_test_3FiYqdcHdWq0a2", // Your Razorpay Key ID
            "amount": "<%= request.getParameter("amount") %>00", // Amount in paise (e.g., 500 for 5.00 INR)
            "currency": "INR",
            "name": "VelvetVibe",
            "description": "Payment for Service",
            "handler": function (response) {
                // Handle payment success
                window.location.href = "paymentSuccess.jsp?paymentId=" + response.razorpay_payment_id+"bookingId="+bookingId;
            },
            "prefill": {
                "name": "Customer Name",
                "email": "<%= email %>"
            },
            "theme": {
                "color": "#3399cc"
            }
        };
        
        var rzp1 = new Razorpay(options);
        rzp1.open();
    </script>
</body>
</html>
