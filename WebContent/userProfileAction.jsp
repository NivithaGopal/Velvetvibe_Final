<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="bean.UserProfileBean"%>
<%@ page import="dao.UserProfileDAO"%>
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

    // Retrieve form parameters
    String fullName = request.getParameter("fullName");
    String dob = request.getParameter("dob");
    String address = request.getParameter("address");
    String mobileNumber = request.getParameter("mobileNumber");

    // Validate form parameters (additional validation can be added as needed)
    if (fullName == null || dob == null || address == null || mobileNumber == null) {
        response.sendRedirect("userProfile.jsp?message=Please fill in all fields");
        return;
    }

    // Create UserProfileBean and set its properties
    UserProfileBean user = new UserProfileBean();
    user.setFullName(fullName);
    user.setDob(java.sql.Date.valueOf(dob)); // Convert String to java.sql.Date
    user.setAddress(address);
    user.setMobileNumber(mobileNumber);
    user.setEmail(email);

    // Update user profile in the database
    UserProfileDAO userDAO = new UserProfileDAO();
    boolean updateSuccess = userDAO.insertOrUpdateUserProfile(user);

    if (updateSuccess) {
        out.println("<script>alert('Profile updated successfully!'); window.location.href='user.jsp';</script>");

    } else {
        out.println("<script>alert('Failed to update profile!'); window.location.href='userProfile.jsp';</script>");
    }
%>
