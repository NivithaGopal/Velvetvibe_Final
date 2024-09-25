<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="dao.UserRegistrationDAO" %>
<%@ page import="bean.UserRegistration" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>

<%
    // Get form parameters
    String fullName = request.getParameter("fullName");
    String dob = request.getParameter("dob");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    // Hash the password using BCrypt
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    // Create UserRegistration object and set properties
    UserRegistration user = new UserRegistration();
    user.setFullName(fullName);
    user.setDob(java.sql.Date.valueOf(dob));
    user.setEmail(email);
    user.setPassword(hashedPassword);  // Store the hashed password

    // Create DAO instance
    UserRegistrationDAO userDAO = new UserRegistrationDAO();

    try {
        // Insert user into the database
        userDAO.insertUser(user);
        out.print("<script type='text/javascript'>");
        out.print("alert('Successfully registered');");
        out.print("window.location.href = 'login.jsp';");
        out.print("</script>"); 
    } catch (SQLException e) {
        // Show an error message if registration fails
        out.print("<script type='text/javascript'>");
        out.print("alert('Registration failed');");
        out.print("window.location.href = 'registration.jsp';");
        out.print("</script>"); 
        e.printStackTrace();
    }
%>
