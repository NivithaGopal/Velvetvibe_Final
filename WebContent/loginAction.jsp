<%@ page import="bean.UserRegistration" %>
<%@ page import="dao.UserRegistrationDAO" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String message = ""; // Variable to hold the message

    // Declare session variable once
    HttpSession httpsession = null; 

    if (email != null && password != null) {
        try {
            UserRegistrationDAO userDao = new UserRegistrationDAO();
            UserRegistration user = userDao.getUserByEmail(email);

            if ("admin@gmail.com".equals(email) && "Admin@123".equals(password)) {
                httpsession = request.getSession(); // Initialize session
            	httpsession.setAttribute("email", email);
            	httpsession.setAttribute("role", "admin") ;
                response.sendRedirect("admin.jsp"); // Redirect to admin page
                return; // Ensure that the rest of the code does not execute
            }

            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                httpsession = request.getSession(); // Initialize session
            	httpsession.setAttribute("email", email);
            	httpsession.setAttribute("role", "user"); 
                response.sendRedirect("user.jsp");
                return; // Ensure that the rest of the code does not execute
            } else {
                message = "Incorrect details or user not registered";
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace for debugging
            message = "An error occurred. Please try again.";
        }
    } else {
        message = "Email and Password are required.";
    }
%>