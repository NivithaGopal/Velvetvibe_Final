<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="bean.feedbackBean" %>
<%@ page import="dao.feedbackDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>VELVETVIBE - Feedback Submission</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
    String email = request.getParameter("email");
    String comments = request.getParameter("comments");

    // Create a new CustomerFeedbackBean object
    feedbackBean feedback = new feedbackBean();
    feedback.setEmail(email);
    feedback.setComments(comments);

    // Create DAO object
    feedbackDAO feedbackDAO = new feedbackDAO();

    // Insert feedback into the database
    boolean success = feedbackDAO.insertFeedback(feedback);

    if (success) {
        out.println("<script>alert('Feedback submitted successfully!'); window.location='feedback.jsp';</script>");
    } else {
        out.println("<script>alert('Feedback submission failed. Please try again.'); window.location='feedback.jsp';</script>");
    }
%>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
