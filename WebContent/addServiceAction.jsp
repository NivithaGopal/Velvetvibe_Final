<%@ page import="dao.ServiceDAO" %>
<%@ page import="bean.addServiceBean" %>

<%
	// Retrieve the form data
    String serviceName = request.getParameter("serviceName");

    // Create an instance of addServiceBean
    addServiceBean serviceBean = new addServiceBean();
    serviceBean.setServiceName(serviceName);

    // Create an instance of AddServiceDAO
    ServiceDAO serviceDAO = new ServiceDAO();

    // Add the service to the database
    boolean isAdded = serviceDAO.addService(serviceBean);

    // Redirect or forward based on the result
    if (isAdded) {
    	out.print("<script type='text/javascript'>");
        out.print("alert('service added Successfully');");
        out.print("window.location.href = 'viewService.jsp';");
        out.print("</script>"); // Redirect to view services page
    } else {
        out.print("<script type='text/javascript'>");
        out.print("alert('Failed to add service. Service name may already exist.');");
        out.print("window.location.href = 'addService.jsp';");
        out.print("</script>");
    }
%>
