<%@ page import="java.util.List" %>
<%@ page import="bean.UserRegistration" %>
<%@ page import="dao.UserRegistrationDAO" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Users</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        h3 {
            margin: 20px 0;
            text-align: center;
        }
        .table {
            margin: 20px auto;
            width: 80%;
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

<%
    UserRegistrationDAO userDAO = new UserRegistrationDAO();
    List<UserRegistration> users = null;

    try {
        users = userDAO.getAllUsers(); // You'll need to implement this method in UserRegistrationDAO
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<div class="container">
<h3>VELVETVIBE</h3>
		<h4 class="text-center">Registered Users</h4>><br>
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
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
            <tr>
                <th>User ID</th>
                <th>Full Name</th>
                <th>Date of Birth</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (users != null && !users.isEmpty()) {
                    for (UserRegistration user : users) {
            %>
                <tr>
                    <td><%= user.getUser_id() %></td>
                    <td><%= user.getFullName() %></td>
                    <td><%= user.getDob() != null ? user.getDob().toString() : "N/A" %></td>
                    <td><%= user.getEmail() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" class="text-center">No registered users found.</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
<div class="text-center mt-4">
            <a href="admin.jsp" class="btn btn-secondary">Back</a>
        </div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
