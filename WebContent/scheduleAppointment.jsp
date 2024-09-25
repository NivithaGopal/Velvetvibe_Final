<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceVelvetvibeDAO"%>
<%@ page import="bean.ServiceVelvetvibeBean"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Schedule Appointment</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f5f5f5;
        font-family: 'Arial', sans-serif;
        color: #333;
        padding-top: 5rem;
    }
    .container {
        margin-top: 2rem;
    }
    .btn-success {
        border-radius: 30px;
        padding: 10px 20px;
        font-size: 1.2rem;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        color: #fff;
        background-color: #343a40;
        border-color: #343a40;
    }
    .btn-success:hover {
        background-color: #495057;
        border-color: #495057;
    }
</style>
</head>
<body>
    <div class="container">
        <h3 class="text-center">Schedule Appointment</h3>

        <%
            String serviceIdStr = request.getParameter("serviceId");
            String serviceName = request.getParameter("serviceName");

            if (serviceIdStr != null && serviceName != null) {
                try {
                    int serviceId = Integer.parseInt(serviceIdStr);

                    // Fetch service details
                    ServiceVelvetvibeDAO velvetvibeDao = new ServiceVelvetvibeDAO();
                    List<ServiceVelvetvibeBean> services = velvetvibeDao.getServiceByIdAndName(serviceId, serviceName);

                    if (services != null && !services.isEmpty()) {
                        ServiceVelvetvibeBean velvetService = services.get(0); // Assuming you need only one service for the booking
        %>

        <form action="saveAppointment.jsp" method="post">
            <input type="hidden" name="serviceId" value="<%= serviceId %>">
            <input type="hidden" name="serviceName" value="<%= serviceName %>">

            <div class="form-group">
                <label for="date">Select Date</label>
                <input type="date" class="form-control" id="date" name="appointmentDate" required>
            </div>

            <div class="form-group">
                <label for="timeSlot">Select Time Slot</label>
                <select class="form-control" id="timeSlot" name="timeSlot" required>
                    <option value="09:00 AM">09:00 AM</option>
                    <option value="10:00 AM">10:00 AM</option>
                    <option value="11:00 AM">11:00 AM</option>
                    <option value="12:00 PM">12:00 PM</option>
                    
                    <option value="02:00 PM">02:00 PM</option>
                    <option value="03:00 PM">03:00 PM</option>
                    <option value="04:00 PM">04:00 PM</option>
                    <option value="05:00 PM">05:00 PM</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success">Schedule Appointment</button>
        </form>

        <%
                    } else {
        %>
        <div class="alert alert-warning" role="alert">No service details found for the selected service.</div>
        <%
                    }
                } catch (NumberFormatException e) {
        %>
        <div class="alert alert-danger" role="alert">Invalid service ID format.</div>
        <%
                } catch (Exception e) {
        %>
        <div class="alert alert-danger" role="alert">Error retrieving service details: <%= e.getMessage() %></div>
        <%
                }
            } else {
        %>
        <div class="alert alert-danger" role="alert">No service ID or service name provided.</div>
        <%
            }
        %>
    </div>
</body>
</html>
