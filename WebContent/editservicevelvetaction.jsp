<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="bean.ServiceVelvetvibeBean" %>
<%@ page import="dao.ServiceVelvetvibeDAO" %>

<%
    // Retrieve the parameters from the form
    String action = request.getParameter("action");
    int servicevv_id = Integer.parseInt(request.getParameter("servicevv_id"));
    int service_id = Integer.parseInt(request.getParameter("service_id"));
    String service_name = request.getParameter("service_name");
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    String description = request.getParameter("description");
    String image1 = request.getParameter("image1");
    String image2 = request.getParameter("image2");
    String image3 = request.getParameter("image3");
    int amount_from = Integer.parseInt(request.getParameter("amount_from"));
    int amount_to =Integer.parseInt(request.getParameter("amount_to"));

    ServiceVelvetvibeDAO serviceDAO = new ServiceVelvetvibeDAO();
    boolean updateSuccess = false;

    if ("update".equals(action)) {
        // Create a ServiceVelvetvibeBean object to hold the updated data
        ServiceVelvetvibeBean service = new ServiceVelvetvibeBean();
        service.setServicevv_id(servicevv_id);
        service.setService_id(service_id);
        service.setService_name(service_name);
        service.setCategoryId(categoryId);
        service.setDescription(description);
        service.setImage1(image1);
        service.setImage2(image2);
        service.setImage3(image3);
        service.setAmount_from(amount_from);
        service.setAmount_to(amount_to);

        // Update the service in the database
        updateSuccess = serviceDAO.updateServiceVelvetvibe(service);
    }

    if (updateSuccess) {
        // Display a success alert and redirect to the view page
        out.println("<script>alert('Service updated successfully!'); window.location.href='viewServiceVelvetvibe.jsp';</script>");
    } else {
        // Display an error alert and stay on the same page
        out.println("<script>alert('Failed to update the service. Please try again.'); window.location.href='editservicevelvet.jsp?id=" + servicevv_id + "';</script>");
    }
%>
