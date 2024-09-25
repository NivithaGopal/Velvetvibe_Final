<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bean.ServiceVelvetvibeBean" %>
<%@ page import="dao.ServiceVelvetvibeDAO" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    String action = request.getParameter("action");
    Boolean result = (Boolean) request.getAttribute("result");

    if (result == null) {
        result = false;
    }

    if (action == null) {
        action = "add";
    }

    ServiceVelvetvibeDAO dao = new ServiceVelvetvibeDAO();
    ServiceVelvetvibeBean service = new ServiceVelvetvibeBean();
    
    try {
        // Correct the parameter names to match your form field names
        String serviceIdStr = request.getParameter("service_id");  // assuming service_id is correct in form
        String categoryIdStr = request.getParameter("categoryId"); // correct name is "categoryId"
        
        // Check for null and parse safely
        int serviceId = (serviceIdStr != null && !serviceIdStr.isEmpty()) ? Integer.parseInt(serviceIdStr) : 0;
        int categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 0;
        
        // Validate the categoryId and serviceId to prevent the error
        if (categoryId == 0) {
            throw new NumberFormatException("Invalid categoryId: 0");
        }

        service.setService_id(serviceId);
        service.setService_name(request.getParameter("service_name"));
        service.setCategoryId(categoryId);
        service.setCategoryName(request.getParameter("category_name"));
        service.setDescription(request.getParameter("description"));
        service.setImage1(request.getParameter("image1"));
        service.setImage2(request.getParameter("image2"));
        service.setImage3(request.getParameter("image3"));
        service.setAmount_from(Integer.parseInt(request.getParameter("amount_from")));
        service.setAmount_to(Integer.parseInt(request.getParameter("amount_to")));
        
        if ("update".equals(action)) {
            result = dao.updateServiceVelvetvibe(service);
        } else {
            result = dao.addServiceVelvetvibe(service);
        }

        if (result) {
            out.println("<script>alert('Service " + (action.equals("update") ? "updated" : "added") + " successfully!'); window.location='viewServiceVelvetvibe.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to " + (action.equals("update") ? "update" : "add") + " service.'); window.location='addServiceVelvetvibe.jsp';</script>");
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("addServiceVelvetvibe.jsp?error=Invalid%20input");
    }
%>
