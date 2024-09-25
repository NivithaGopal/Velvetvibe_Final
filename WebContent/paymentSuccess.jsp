<%@ page import="dao.BookingDAO, java.sql.*, javax.servlet.http.HttpSession" %>
<%
    // Retrieve the payment ID and booking ID from the request parameters
    String paymentId = request.getParameter("paymentId");
    String bookingId = request.getParameter("bookingId");

    // Debugging output
    System.out.println("Payment ID: " + paymentId);
    System.out.println("Booking ID: " + bookingId);

    if (paymentId == null || bookingId == null) {
        response.sendRedirect("viewFavourites.jsp?message=Invalid payment details");
        return;
    }

    // Optionally, update payment status in the database
    BookingDAO bookingDAO = new BookingDAO();
    boolean isUpdated = bookingDAO.updatePaymentStatus(paymentId, bookingId);

    // Prepare the response page
    out.println("<!DOCTYPE html>");
    out.println("<html lang='en'>");
    out.println("<head>");
    out.println("<meta charset='UTF-8'>");
    out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
    out.println("<title>Payment Success</title>");
    out.println("<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>");
    out.println("</head>");
    out.println("<body>");
    out.println("<div class='container mt-5'>");
    out.println("<div class='alert alert-success text-center' role='alert'>");
    out.println("<h4 class='alert-heading'>Payment Successful!</h4>");
    out.println("<p>Your payment was successful. Your appointment has been booked.</p>");
    out.println("<p><strong>Payment ID:</strong> " + paymentId + "</p>"); // Print the payment ID
    out.println("<p><strong>Booking ID:</strong> " + bookingId + "</p>"); // Optionally print the booking ID
    out.println("<hr>");
    out.println("<p class='mb-0'>Thank you for choosing our service.</p>");
    out.println("<a href='viewFavourites.jsp' class='btn btn-primary mt-3'>Go to Favourites</a>");
    out.println("</div>");
    out.println("</div>");
    out.println("<script src='https://code.jquery.com/jquery-3.5.1.slim.min.js'></script>");
    out.println("<script src='https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js'></script>");
    out.println("<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>");
    out.println("</body>");
    out.println("</html>");
%>
