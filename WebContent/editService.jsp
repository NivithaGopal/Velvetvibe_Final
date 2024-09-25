<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="bean.addServiceBean"%>

<%
	// Get the service ID from the request
    String serviceIdStr = request.getParameter("service_id");
    int serviceId = Integer.parseInt(serviceIdStr);

    // Create an instance of AddServiceDAO
    ServiceDAO serviceDAO = new ServiceDAO();

    // Retrieve the service details
    addServiceBean service = serviceDAO.getServiceById(serviceId);

    if (request.getMethod().equalsIgnoreCase("POST")) {
        // Get the updated service name from the form
        String updatedServiceName = request.getParameter("serviceName");

        // Update the service details
        service.setServiceName(updatedServiceName);
        boolean isUpdated = serviceDAO.updateService(service);

        // Handle the result
        if (isUpdated) {
            out.print("<script type='text/javascript'>");
            out.print("alert('Service updated successfully!');");
            out.print("window.location.href = 'viewService.jsp';");
            out.print("</script>");
        } else {
            out.print("<script type='text/javascript'>");
            out.print("alert('Failed to update service. Please try again.');");
            out.print("</script>");
        }
    }
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Edit Service - VELVETVIBE</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
            color: #333;
        }

        .service-container {
            max-width: 500px;
            width: 100%;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .service-header {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .service-header h3 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #212529;
        }

        .btn-custom {
            width: 48%;
            background-color: #343a40;
            border-color: #343a40;
            border-radius: 5px;
            padding: 10px;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #495057;
            border-color: #495057;
        }

        .btn-cancel {
            width: 48%;
            background-color: #6c757d;
            border-color: #6c757d;
            border-radius: 5px;
            padding: 10px;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background-color: #adb5bd;
            border-color: #adb5bd;
        }
        .form-label {
            font-weight: bold;
            color: #495057;
        }

        .form-control {
            border-radius: 10px;
            padding: 15px;
            font-size: 1rem;
            background: #f8f9fa;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
            border: 1px solid #ced4da;
        }
    </style>
    <script type="text/javascript">
    
 function validateform() {
    	
    	var serviceName=document.getElementById("serviceName").value;
    	var nameRegex = /^[a-zA-Z\s]+$/;
    	
    	if(serviceName == ""){
    		alert("Service Name is Required!");
    		document.getElementById("serviceName").focus();
    		return false;
    	}
    	if (!nameRegex.test(serviceName)) {
    		alert("Service Name can only contain letters and spaces.");
            document.getElementById("serviceName").focus();
            return false;
    	}
		return true;
	}
    </script>
  
</head>
<body>
<%
    HttpSession httpsession = request.getSession(false); // Retrieve existing session or null if none exists
    String role = null;

    if (httpsession != null) {
        role = (String) httpsession.getAttribute("role");
    }

    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not logged in or not an admin
        return;
    }
%>
    <div class="service-container">
        <div class="service-header">
            <h3>Edit Service</h3>
        </div>
        <form method="post" action="" onsubmit="return validateform()">
            <div class="mb-3">
                <label for="serviceName" class="form-label">Service Name</label>
                <input type="text" class="form-control" id="serviceName" name="serviceName" value="<%= service.getServiceName() %>" >
            </div>
            <div class="d-flex justify-content-between mt-3">
                <button type="submit" class="btn btn-custom">Update Service</button>
                <a href="viewService.jsp" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
