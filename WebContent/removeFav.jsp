<%@ page import="dao.FavoriteDAO, bean.ServiceVelvetvibeBean, dao.ServiceVelvetvibeDAO, dao.UserRegistrationDAO, bean.UserRegistration, java.util.*" %>
<%
    HttpSession httpsession = request.getSession(false);
    String email = null;

    if (httpsession != null) {
        email = (String) httpsession.getAttribute("email");
    }

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

    int userId = user.getUser_id();

    // Get the serviceId from the request parameter
    String serviceIdParam = request.getParameter("serviceId");
    if (serviceIdParam == null) {
        response.sendRedirect("viewFavorites.jsp?message=Invalid request");
        return;
    }

    int serviceId;
    try {
        serviceId = Integer.parseInt(serviceIdParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("viewFavorites.jsp?message=Invalid service ID");
        return;
    }

    // Create an instance of FavoriteDAO
    FavoriteDAO favoriteDAO = new FavoriteDAO();

    // Remove the service from the user's favorites
    boolean isRemoved = favoriteDAO.removeFavorite(userId, serviceId);

    // Set alert messages based on the removal result
    if (isRemoved) {
        request.setAttribute("alertType", "success");
        request.setAttribute("alertMessage", "Service removed from favorites");
    } else {
        request.setAttribute("alertType", "danger");
        request.setAttribute("alertMessage", "Failed to remove service from favorites");
    }
%>

<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
        // Function to confirm removal
        function confirmRemoval() {
            return confirm("Are you sure you want to remove this service from your favorites?");
        }

        // Display alert based on server-side messages
        window.onload = function() {
            var alertType = "<%= request.getAttribute("alertType") %>";
            var alertMessage = "<%= request.getAttribute("alertMessage") %>";
            
            if (alertMessage) {
                if (confirmRemoval()) {
                    alert(alertMessage);
                    window.location.href = "viewFavourites.jsp";
                } else {
                    window.location.href = "viewFavourites.jsp";
                }
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- Optional: Add additional content or layout -->
    </div>
</body>
</html>
