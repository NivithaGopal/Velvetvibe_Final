<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dao.GalleryDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession httpsession = request.getSession(false); // Retrieve existing session or null if none exists
    String role = null;

    // Check if the session is valid and retrieve the user role
    if (httpsession != null) {
        role = (String) httpsession.getAttribute("role");
    }

    // Redirect to login page if not logged in or not an admin
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    String galleryId = request.getParameter("galleryId");
    boolean isSuccess = false;

    if (galleryId != null && !galleryId.isEmpty()) {
        try {
            GalleryDAO galleryDAO = new GalleryDAO();
            isSuccess = galleryDAO.deleteGallery(Integer.parseInt(galleryId));

            if (isSuccess) {
                out.print("<script type='text/javascript'>");
                out.print("alert('Gallery deleted successfully!');");
                out.print("window.location.href = 'viewGallery.jsp';");
                out.print("</script>");
            } else {
                out.print("<script type='text/javascript'>");
                out.print("alert('Failed to delete the gallery.');");
                out.print("window.location.href = 'viewGallery.jsp';");
                out.print("</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("<script type='text/javascript'>");
            out.print("alert('An error occurred while deleting the gallery. Please try again later.');");
            out.print("window.location.href = 'viewGallery.jsp';");
            out.print("</script>");
        }
    } else {
        out.print("<script type='text/javascript'>");
        out.print("alert('Invalid gallery ID.');");
        out.print("window.location.href = 'viewGallery.jsp';");
        out.print("</script>");
    }
%>
