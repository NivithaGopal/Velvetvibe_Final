<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <title>Add Service - VELVETVIBE</title>
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
            width: 100%;
            background-color: #343a40;
            border-color: #343a40;
            border-radius: 30px;
            padding: 10px 20px;
            font-size: 1.2rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #495057;
            border-color: #495057;
        }

        .form-label {
            font-weight: bold;
            color: #495057;
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 15px;
            font-size: 1rem;
            background: #f8f9fa;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
            border: 1px solid #ced4da;
        }

        .text-muted {
            color: #6c757d !important;
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
  
        
    <div class="service-container">
        <div class="service-header">
            <h3>VELVETVIBE</h3>
            <p class="text-muted">Add New Salon Service</p>
            
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
        </div>
        <form action="addServiceAction.jsp" method="post" onsubmit="return validateform()">
            <div class="mb-3">
                <label for="serviceName" class="form-label">Service Name</label>
                <input type="text" class="form-control" id="serviceName" name="serviceName" >
            </div>
           
            <div class="d-flex justify-content-center mt-3">
                <button type="submit" class="btn btn-custom">Add Service</button>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
</body>
</html>
