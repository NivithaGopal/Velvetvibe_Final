<%@ page import="dao.FavoriteDAO" %>
<%
    String userIdStr = request.getParameter("userId");
    String servicevvIdStr = request.getParameter("servicevvId");
    
    out.print(userIdStr);
    out.print(servicevvIdStr);


    if (userIdStr != null && servicevvIdStr != null) {
        try {
            int userId = Integer.parseInt(userIdStr);
            int servicevvId = Integer.parseInt(servicevvIdStr);

            // Use FavouriteDAO to add this to the favorites table
            FavoriteDAO favouriteDAO = new FavoriteDAO();
            boolean result = favouriteDAO.addFavourite(userId, servicevvId);

            if (result) {
                response.sendRedirect("viewFavourites.jsp"); // Redirect to viewFavorites.jsp

            } else {
                out.println("<div class=\"alert alert-danger\" role=\"alert\">Failed to add to favourites!</div>");
            }
        } catch (NumberFormatException e) {
            out.println("<div class=\"alert alert-danger\" role=\"alert\">Invalid user or service ID format.</div>");
        }
    } else {
        out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing user or service ID.</div>");
    }
%>
