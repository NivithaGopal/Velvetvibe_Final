<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="dao.UserRegistrationDAO" %>
<%@ page import="bean.UserRegistration" %>
<%
    // Retrieve form data
    String email = request.getParameter("email");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    
    UserRegistrationDAO userDao = new UserRegistrationDAO();

    // Check if email is provided
    if (email == null || email.isEmpty()) {
        out.println("<p class='text-danger text-center'>Email is required.</p>");
    } else {
        // Check if new password and confirm password match
        if (!newPassword.equals(confirmPassword)) {
            out.println("<p class='text-danger text-center'>Passwords do not match. Please try again.</p>");
        } else {
            // Hash the new password
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            boolean result = userDao.updatePasswordByEmail(email, hashedPassword); // Update password in the database
            
            if (result) {
            	 out.print("<script type='text/javascript'>");
                 out.print("alert('Password has been reset successfully!');");
                 out.print("window.location.href = 'login.jsp';");
                 out.print("</script>");
            } else {
                out.println("<p class='text-danger text-center'>Failed to reset password. Please check the email provided.</p>");
            }
        }
    }
%>
