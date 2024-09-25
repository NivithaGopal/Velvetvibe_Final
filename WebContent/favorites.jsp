<%@page import="bean.UserRegistration"%>
<%@ page import="java.util.List, bean.ServiceVelvetvibeBean, dao.FavoriteDAO" %>
<%
UserRegistration user=new UserRegistration();
    FavoriteDAO favoriteDAO = new FavoriteDAO();
    List<ServiceVelvetvibeBean> favoriteServices = favoriteDAO.getFavoriteServices(user.getUser_id());

    if (favoriteServices != null && !favoriteServices.isEmpty()) {
%>
    <div class="container">
        <div class="row">
            <% for (ServiceVelvetvibeBean service : favoriteServices) { %>
                <div class="col-md-4">
                    <div class="card mb-4 shadow-sm">
                        <img src="<%= service.getImage1() %>" class="card-img-top" alt="<%= service.getService_name() %> Image" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title"><%= service.getService_name() %></h5>
                            <h6 class="card-subtitle mb-2 text-muted"><%= service.getCategoryName() %></h6>
                            <p class="card-text"><%= service.getDescription() %></p>
                            <p class="card-text">Price Range: ₹<%= service.getAmount_from() %> - ₹<%= service.getAmount_to() %></p>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
<%
    } else {
        out.println("<div class='alert alert-warning'>You have no favorite services yet.</div>");
    }
%>
