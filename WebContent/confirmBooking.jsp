<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="dao.*, bean.*" %>

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

    int userId = user.getUserId(); // Assuming getUserId() returns the user's ID
    out.print("User ID: " + userId); // Debug line

%>

<%
    // Retrieve payment ID and other booking details
    String paymentId = request.getParameter("razorpay_payment_id");
    String serviceId = request.getParameter("serviceId");
    String serviceName = request.getParameter("serviceName");
    int amountFrom = Integer.parseInt(request.getParameter("amountFrom"));
    int amountTo = Integer.parseInt(request.getParameter("amountTo"));
    String appointmentDate = request.getParameter("appointmentDate");
    String appointmentTime = request.getParameter("appointmentTime");
    String userEmail = email;  // Assuming you retrieved the email earlier

    // Validate payment ID
    if (paymentId == null || paymentId.isEmpty()) {
        // Handle error: Payment ID not available
        response.sendRedirect("error.jsp?message=Payment failed or was not processed correctly");
        return;
    }

    // Create a BookingBean object to hold booking details
    BookingBean booking = new BookingBean();
    booking.setServiceId(Integer.parseInt(serviceId));
    booking.setServiceName(serviceName);
    booking.setAmountFrom(amountFrom);
    booking.setAmountTo(amountTo);
    booking.setAppointmentDate(appointmentDate);
    booking.setAppointmentTime(appointmentTime);
    booking.setUserEmail(userEmail);
    booking.setPaymentId(paymentId);

    // Create BookingDAO instance to save the booking
    BookingDAO bookingDAO = new BookingDAO();
    boolean isSaved = bookingDAO.saveBooking(booking);
    
    // Create FavoriteDAO instance to remove the favorite
    FavoriteDAO favoriteDAO = new FavoriteDAO();

    if (isSaved) {
     /*    // Remove the service from favorites after booking is saved
        boolean isFavoriteRemoved = favoriteDAO.removeFavorite(userId, Integer.parseInt(serviceId)); // Ensure serviceId is an integer

        if (!isFavoriteRemoved) {
            System.out.println("Failed to remove favorite service for user: " + userId);
        } */

        // Booking saved successfully
        double totalAmount = (amountFrom + amountTo) / 2.0; // Assuming you want the average for display
        response.sendRedirect("success.jsp?serviceName=" + URLEncoder.encode(serviceName, "UTF-8") +
                "&appointmentDate=" + URLEncoder.encode(appointmentDate, "UTF-8") +
                "&appointmentTime=" + URLEncoder.encode(appointmentTime, "UTF-8") +
                "&totalAmount=" + totalAmount +
                "&message=" + URLEncoder.encode("Thank you for booking!", "UTF-8"));
    } else {
        // Failed to save booking
        response.sendRedirect("error.jsp?message=Booking could not be saved.");
    }
%>
