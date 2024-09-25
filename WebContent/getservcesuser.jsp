<%@page import="dao.UserRegistrationDAO"%>
<%@page import="bean.UserRegistration"%>
<%@page import="dao.ServiceDAO"%>
<%@page import="dao.ServiceVelvetvibeDAO"%>
<%@page import="bean.addServiceBean"%>
<%@page import="bean.ServiceVelvetvibeBean"%>
<%@page import="java.util.List"%>
<%@page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Service Details</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Arial', sans-serif;
            color: #333;
            padding-top: 5rem;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border: none;
            overflow: hidden;
            background: #f8f9fa;
            margin-bottom: 20px;
        }
        .card-header {
            background: linear-gradient(135deg, #6c757d 0%, #343a40 100%);
            color: #fff;
            text-align: center;
            padding: 20px;
            font-size: 1.5rem;
            font-weight: bold;
        }
        .img-thumbnail {
            width: 100%;
            height: 100%;
            object-fit: cover;
            margin-bottom: 15px;
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
        .alert {
            border-radius: 10px;
        }
        h3 {
            font-size: 2rem;
            font-weight: bold;
            color: #212529;
            text-align: center;
            margin-bottom: 2rem;
        }
    </style>

</head>
<body>

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

    UserRegistrationDAO userDAO = new UserRegistrationDAO();
    UserRegistration user = userDAO.getUserByEmail(email);

    if (user == null) {
        response.sendRedirect("login.jsp?message=User not found");
        return;
    }
%>

<div class="container">
    <h3>VELVETVIBE</h3>
    <%
        String serviceIdStr = request.getParameter("serviceId");

        if (serviceIdStr != null) {
            try {
                int serviceId = Integer.parseInt(serviceIdStr);
                ServiceDAO serviceDao = new ServiceDAO();
                addServiceBean service = serviceDao.getServiceById(serviceId);

                if (service != null) {
                    String serviceName = service.getServiceName();
                    %>
                    <h4 class="text-center">Service Details: <%= serviceName %></h4><br>
                    <%
                    if (serviceName != null && !serviceName.isEmpty()) {
                        ServiceVelvetvibeDAO velvetvibeDao = new ServiceVelvetvibeDAO();
                        List<ServiceVelvetvibeBean> services = velvetvibeDao.getServiceByIdAndName(serviceId, serviceName);

                        if (services != null && !services.isEmpty()) {
                            for (ServiceVelvetvibeBean velvetService : services) {
                                %>
                                <div class="card service-card">
                                    <div class="card-header">
                                        <%= velvetService.getCategoryName() %>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>Description:</strong> <%= velvetService.getDescription() %></p>
                                        <p><strong>Amount From:</strong> &#x20B9 <%= velvetService.getAmount_from() %></p>
                                        <p><strong>Amount To:</strong> &#x20B9 <%= velvetService.getAmount_to() %></p>

                                        <div class="row">
                                            <div class="col-md-4">
                                                <img src="<%= velvetService.getImage1() %>" class="img-thumbnail" alt="Service Image 1">
                                            </div>
                                            <div class="col-md-4">
                                                <img src="<%= velvetService.getImage2() %>" class="img-thumbnail" alt="Service Image 2">
                                            </div>
                                            <div class="col-md-4">
                                                <img src="<%= velvetService.getImage3() %>" class="img-thumbnail" alt="Service Image 3">
                                            </div>
                                        </div>

                                        <div class="btn-container d-flex justify-content-between">
    <form action="addToFav.jsp" method="post" class="mr-2">
        <input type="hidden" name="userId" value="<%= user.getUser_id() %>">
        <input type="hidden" name="servicevvId" value="<%= velvetService.getServicevv_id() %>">
        <button type="submit" class="btn btn-success">Add to Favourite</button>
    </form>
    
<form action="bookNowUser.jsp" method="post" class="ml-2">
    <input type="hidden" name="userId" value="<%= user.getUser_id() %>">
    <input type="hidden" name="serviceId" value="<%= velvetService.getService_id() %>">
    <input type="hidden" name="serviceName" value="<%= velvetService.getService_name() %>"> <!-- Assuming you have this -->
    <input type="hidden" name="amountFrom" value="<%= velvetService.getAmount_from()%>"> <!-- Adjust as necessary -->
    <input type="hidden" name="amountTo" value="<%= velvetService.getAmount_to() %>"> <!-- Adjust as necessary -->
    <button type="submit" class="btn btn-success">Book Now</button>
</form>


</div>

                                    </div>
                                </div>
                                <%
                            }
                        } else {
                            %>
                            <div class="alert alert-warning" role="alert">No service found in ServiceVelvetvibeDAO for the given ID and name.</div>
                            <%
                        }
                    } else {
                        %>
                        <div class="alert alert-danger" role="alert">Service Name not provided for ServiceVelvetvibeDAO lookup.</div>
                        <%
                    }
                } else {
                    %>
                    <div class="alert alert-danger" role="alert">No service found in ServiceDAO for the given ID.</div>
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
            <div class="alert alert-danger" role="alert">No service ID provided.</div>
            <%
        }
    %>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
