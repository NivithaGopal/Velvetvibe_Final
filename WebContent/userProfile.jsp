<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="bean.UserProfileBean"%>
<%@ page import="dao.UserProfileDAO"%>

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

    // Fetch user details from the database
    UserProfileDAO userDAO = new UserProfileDAO();
    UserProfileBean user = userDAO.getUserByEmail(email);

    if (user == null) {
        response.sendRedirect("login.jsp?message=User not found");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background */
            color: #333; /* Dark gray text */
        }
        .container {
            background-color: #fff; /* White background for the form */
            padding: 2rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            border-radius: 8px;
        }
        h2 {
            color: #000; /* Black heading */
        }
        .form-label {
            color: #333; /* Dark gray for labels */
        }
        .form-control {
            background-color: #f1f1f1; /* Light gray input background */
            border: 1px solid #ccc; /* Border with a light gray tone */
            color: #000; /* Black text for input */
        }
        .form-control:focus {
            border-color: #495057; /* Dark gray border on focus */
            box-shadow: none; /* Remove default focus shadow */
        }
        .btn-primary {
            background-color: #495057; /* Dark gray button */
            border-color: #495057; /* Dark gray button border */
        }
        .btn-primary:hover {
            background-color: #343a40; /* Darker gray on hover */
            border-color: #343a40;
        }
        /* Center the form container */
        .form-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
        }
        
        h3, h4 {
            text-align: center; /* Center-align the headings */
        }
        h3 {
            font-weight: bold; /* Make h3 bold */
        }
 
    </style>
    
    <script type="text/javascript">
        function validateForm() {
            var fullName = document.getElementById("fullName").value;
            var dob = document.getElementById("dob").value;
            var address = document.getElementById("address").value;
            var mobileNumber = document.getElementById("mobileNumber").value;

            var fullNamePattern = /^[a-zA-Z\s]+$/;
            var addressPattern = /^[a-zA-Z0-9\s,.-]+$/;
            var mobileNumberPattern = /^[6-9]\d{9}$/;

            if (fullName == "") {
                alert("Full Name required");
                document.getElementById("fullName").focus();
                return false;
            }
            if (!fullNamePattern.test(fullName)) {
                alert("Full Name should contain only letters and spaces");
                document.getElementById("fullName").focus();
                return false;
            }
            if (dob == "") {
                alert("DOB required");
                document.getElementById("dob").focus();
                return false;
            }
            if (address == "") {
                alert("Address required");
                document.getElementById("address").focus();
                return false;
            }
            if (!addressPattern.test(address)) {
                alert("Address should contain only alphanumeric characters and ,.-");
                document.getElementById("address").focus();
                return false;
            }
            if (mobileNumber == "") {
                alert("Mobile Number required");
                document.getElementById("mobileNumber").focus();
                return false;
            }
            if (!mobileNumberPattern.test(mobileNumber)) {
                alert("Mobile Number should be a valid Indian number starting with 6-9 and exactly 10 digits");
                document.getElementById("mobileNumber").focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="form-wrapper">
        <div class="container">
        	<h3>VELVETVIBE</h3>
            <h4>User Profile</h4><br>
            <form action="userProfileAction.jsp" method="post" onsubmit="return validateForm()">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" value="<%= user.getFullName() %>" >
                </div>
                <div class="mb-3">
                    <label for="dob" class="form-label">Date of Birth</label>
                    <input type="date" id="dob" name="dob" class="form-control" value="<%= user.getDob() %>" >
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" id="address" name="address" class="form-control" value="<%= user.getAddress() %>" >
                </div>
                <div class="mb-3">
                    <label for="mobileNumber" class="form-label">Mobile Number</label>
                    <input type="text" id="mobileNumber" name="mobileNumber" class="form-control" value="<%= user.getMobileNumber() %>" >
                </div>
                <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
