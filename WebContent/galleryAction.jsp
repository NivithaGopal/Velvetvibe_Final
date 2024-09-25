<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="dao.GalleryDAO" %>
<%@ page import="bean.GalleryBean" %>

<%
    String action = request.getParameter("action");
    String image1 = request.getParameter("image1");
    String image2 = request.getParameter("image2");
    String galleryId = request.getParameter("galleryId");

    GalleryDAO galleryDAO = new GalleryDAO();
    boolean isSuccess = false;

    if ("add".equals(action) && image1 != null && image2 != null) {
        // Add gallery
        GalleryBean gallery = new GalleryBean();
        gallery.setImage1(image1);
        gallery.setImage2(image2);

        isSuccess = galleryDAO.addGallery(gallery);

        if (isSuccess) {
            out.print("<script type='text/javascript'>");
            out.print("alert('Gallery images added successfully!');");
            out.print("window.location.href = 'viewGallery.jsp';");
            out.print("</script>");
        } else {
            out.print("<script type='text/javascript'>");
            out.print("alert('Failed to add gallery images.');");
            out.print("window.location.href = 'addGallery.jsp';");
            out.print("</script>");
        }
    } else if ("update".equals(action) && galleryId != null && !galleryId.isEmpty() && image1 != null && image2 != null) {
        // Update gallery
        GalleryBean gallery = new GalleryBean();
        gallery.setGalleryId(Integer.parseInt(galleryId));
        gallery.setImage1(image1);
        gallery.setImage2(image2);

        try {
            isSuccess = galleryDAO.updateGallery(gallery);

            if (isSuccess) {
                out.print("<script type='text/javascript'>");
                out.print("alert('Gallery updated successfully!');");
                out.print("window.location.href = 'viewGallery.jsp';");
                out.print("</script>");
            } else {
                out.print("<script type='text/javascript'>");
                out.print("alert('Failed to update the gallery. Please try again.');");
                out.print("window.location.href = 'editGallery.jsp?galleryId=" + galleryId + "';");
                out.print("</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("<script type='text/javascript'>");
            out.print("alert('An error occurred while updating the gallery. Please try again later.');");
            out.print("window.location.href = 'editGallery.jsp?galleryId=" + galleryId + "';");
            out.print("</script>");
        }
    } else {
        // Invalid form submission
        out.print("<script type='text/javascript'>");
        out.print("alert('Invalid form submission.');");
        out.print("window.history.back();");
        out.print("</script>");
    }
%>
