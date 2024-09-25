<%@ page import="dao.FavoriteDAO" %>

<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    int servicevvId = Integer.parseInt(request.getParameter("servicevvId"));
    String action = request.getParameter("action");
    
    FavoriteDAO favouriteDAO = new FavoriteDAO();
    boolean result = false;
    
    if ("add".equals(action)) {
        result = favouriteDAO.addFavourite(userId, servicevvId);
    } else if ("remove".equals(action)) {
        result = favouriteDAO.removeFavourite(userId, servicevvId);
    }
    
    if (result) {
        out.println("<script>alert('Action successful');</script>");
    } else {
        out.println("<script>alert('Action failed');</script>");
    }
    
    response.sendRedirect("viewFavourites.jsp");
%>
