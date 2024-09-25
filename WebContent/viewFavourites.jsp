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

    // Fetch favorite items for the user
    FavoriteDAO favoriteDAO = new FavoriteDAO();
    List<Integer> favoriteServiceIds = favoriteDAO.getFavoriteServiceIds(userId);

    if (favoriteServiceIds != null && !favoriteServiceIds.isEmpty()) {
        ServiceVelvetvibeDAO velvetvibeDAO = new ServiceVelvetvibeDAO();
        List<ServiceVelvetvibeBean> favoriteServices = velvetvibeDAO.getServicesByIds(favoriteServiceIds);

        if (favoriteServices != null && !favoriteServices.isEmpty()) {
%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style type="text/css">
body {
    background-color: #f5f5f5; /* Light gray background */
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
}

.container {
    max-width: 1200px;
}

.card {
    border: 1px solid #333; /* Black border */
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    background-color: #fff; /* White background */
    display: flex;
    flex-direction: column;
    height: 100%;
    position: relative;
    margin-bottom: 1rem;
}

.card-img-top {
    height: 350px;
    object-fit: cover; /* Ensures the image covers the area without distortion */
    width: 100%;
}

.card-body {
    display: flex;
    flex-direction: column;
    flex: 1;
    padding: 1rem;
}

.card-title {
    font-size: 1.25rem;
    color: #333; /* Dark gray text */
    margin-bottom: 0.75rem;
}

.card-text {
    font-size: 0.875rem;
    color: #666; /* Medium gray text */
    flex: 1;
}

.btn-success {
    background-color: #333; /* Black background */
    border-color: #333; /* Black border */
    color: #fff; /* White text */
}

.wishlist-icon {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 1.5rem;
    color: #666; /* Gray icon color */
    cursor: pointer;
}

.wishlist-icon.active {
    color: #333; /* Dark gray when active */
}

.card-footer {
    text-align: center;
    padding: 0.75rem 1.25rem;
    background-color: #f5f5f5; /* Light gray background */
}

.alert {
    text-align: center;
    color: #333; /* Dark gray text */
}

h3 {
    font-size: 2rem;
    font-weight: bold;
    color: #212529;
    text-align: center;
}
</style>
</head>
<body>
    <div class="container">
        <h3>VELVETVIBE</h3>
        <h4 class="text-center mb-4" style="color: #333;">Your Favorite Services</h4><br>
        <div class="row">
            <% for (ServiceVelvetvibeBean service : favoriteServices) {
                // Truncate description to a maximum of 100 characters
                String description = service.getDescription();
                String truncatedDescription = description.length() > 100 ? description.substring(0, 100) + "..." : description;

                // Check if the service is in the wishlist
                boolean isInWishlist = favoriteServiceIds.contains(service.getServicevv_id());
            %>
            <div class="col-md-4 mb-4">
                <div class="card">
                  <a href="removeFav.jsp?serviceId=<%= service.getServicevv_id() %>" class="wishlist-icon <%= isInWishlist ? "active" : "" %>">
                        <i class="fas fa-heart"></i>
                    </a>
                    <img src="<%= service.getImage1() %>" class="card-img-top" alt="Service Image 1">
                    <div class="card-body">
                        <h5 class="card-title"><%= service.getCategoryName() %></h5>
                        <p class="card-text" title="<%= description %>"><%= truncatedDescription %></p>
                        <p class="card-text">
                            <strong>Amount From:</strong> &#x20B9 <%= service.getAmount_from() %><br>
                            <strong>Amount To:</strong> &#x20B9 <%= service.getAmount_to() %>
                        </p>
                    </div>
                    <div class="card-footer">
    <a href="bookNow.jsp?serviceId=<%= service.getServicevv_id() %>&serviceName=<%= service.getCategoryName() %>&amountFrom=<%= service.getAmount_from() %>&amountTo=<%= service.getAmount_to() %>" class="btn btn-success">Book Now</a>
</div>

                </div>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>
<%
        } else {
%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style type="text/css">
body {
    background-color: #f5f5f5; /* Light gray background */
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
}

.alert {
    text-align: center;
    color: #333; /* Dark gray text */
}
</style>
</head>
<body>
    <div class="container">
        <div class="alert alert-warning" role="alert">No favorite services found.</div>
    </div>
</body>
</html>
<%
        }
    } else {
%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style type="text/css">
body {
    background-color: #f5f5f5; /* Light gray background */
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
}

.alert {
    text-align: center;
    color: #333; /* Dark gray text */
}
</style>
</head>
<body>
    <div class="container">
        <div class="alert alert-warning" role="alert">No favorite services found.</div>
    </div>
</body>
</html>
<%
    }
%>
