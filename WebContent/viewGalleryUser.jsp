<%@ page import="java.util.List" %>
<%@ page import="bean.GalleryBean" %>
<%@ page import="dao.GalleryDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery View</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
      <style>
        .card-img-top {
            width: 100%; /* Adjust as needed */
            height: 500px; /* Fixed height */
            object-fit: cover;
            padding: 20px; /* Maintains aspect ratio and covers the area */
        }
        .additional-img {
            width: 100%; /* Adjust as needed */
            height: 200px; /* Fixed height */
            object-fit: cover; /* Maintains aspect ratio and covers the area */
        }
        
        .icon-btn {
            border: none;
            background: none;
            padding: 5px;
            cursor: pointer;
        }
        .icon-btn:hover {
            color: #007bff;
        }
        .add-btn {
            margin-bottom: 20px;
            background-color: #495057;
            border-color: #495057;
        }
        h3 {
            font-size: 2rem;
            font-weight: bold;
            color: #212529;
            text-align: center;
        } 
        .card:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<%
		HttpSession httpsession = request.getSession(false); // Retrieve existing session or null if none exists
		String email = null;

		if (httpsession != null) {
			email = (String) httpsession.getAttribute("email");
		}

		if (email == null) {
			response.sendRedirect("login.jsp"); // Redirect to login page if not logged in or not an admin
			return;
		}
	%>
    <div class="container mt-4">
       <h3>VELVETVIBE</h3>
        <h4 class="text-center">Gallery Images</h4><br>
        
        

        <div class="row">
            <% 
                GalleryDAO galleryDAO = new GalleryDAO();
                List<GalleryBean> galleries = galleryDAO.getAllGalleries();
                for (GalleryBean gallery : galleries) {
            %>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <img src="<%= gallery.getImage1() %>" class="card-img-top" alt="Image 1">
                        <div class="card">
                            <% if (gallery.getImage2() != null && !gallery.getImage2().isEmpty()) { %>
                                <img src="<%= gallery.getImage2() %>" class="card-img-top" alt="Image 2">
                            <% } %>
                            <!-- Edit and Delete Buttons -->
                           <div class="d-flex justify-content-around mt-2">
                       
                    </div>
                        
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
