<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aijo Website Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        /* Background with a gradient of dark and light grays */
        body {
            background: linear-gradient(135deg, #333333 0%, #777777 100%);
            font-family: 'Arial', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        /* Card styles */
        .card {
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border: none;
            overflow: hidden;
            background: #f8f9fa;
        }

        .card-header {
            background: linear-gradient(135deg, #6c757d 0%, #343a40 100%);
            color: #fff;
            text-align: center;
            padding: 20px;
            font-size: 1.5rem;
            font-weight: bold;
        }

        /* Form styles */
        .form-control {
            border-radius: 10px;
            border: 1px solid #ced4da;
            padding: 15px;
            font-size: 1rem;
            background: #e9ecef;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .form-group label {
            font-weight: bold;
            color: #495057;
            margin-bottom: 10px;
        }

        /* Button styles */
        .btn-primary {
            background-color: #343a40;
            border-color: #343a40;
            border-radius: 30px;
            padding: 10px 20px;
            font-size: 1.2rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #495057;
            border-color: #495057;
        }

        /* Footer link styles */
        .card-footer {
            background-color: #f8f9fa;
            text-align: center;
            padding: 15px;
            border-top: 1px solid #ced4da;
        }

        .card-footer a {
            color: #343a40;
            font-weight: bold;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .card-footer a:hover {
            color: #495057;
        }
    </style>
    <script type="text/javascript">
    function validateRegForm() {
        var fullname = document.getElementById("fullName").value;
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;

        if (fullname == "") {
            alert("Full Name is required");
            document.getElementById("fullName").focus();
            return false;
        }

        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$/;

        if (email == "") {
            alert("Email required");
            document.getElementById("email").focus();
            return false;
        }
        if (!emailPattern.test(email)) {
            alert("Please enter a valid email address.");
            document.getElementById("email").focus();
            return false;
        }
        if (password == "") {
            alert("Password required");
            document.getElementById("password").focus();
            return false;
        }
        if (!passwordPattern.test(password)) {
            alert("Password must be 8-12 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character.");
            document.getElementById("password").focus();
            return false;
        }
        if (confirmPassword == "") {
            alert("Confirm Password is required");
            document.getElementById("confirmPassword").focus();
            return false;
        }
        if (password !== confirmPassword) {
            alert("Passwords do not match.");
            document.getElementById("confirmPassword").focus();
            return false;
        }
        return true;
    }

    function togglePasswordVisibility(fieldId, iconId) {
        var passwordField = document.getElementById(fieldId);
        var toggleIcon = document.getElementById(iconId);

        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.classList.remove("bi-eye-slash");
            toggleIcon.classList.add("bi-eye");
        } else {
            passwordField.type = "password";
            toggleIcon.classList.remove("bi-eye");
            toggleIcon.classList.add("bi-eye-slash");
        }
    }

</script>

</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Create Your VelvetVibe Account
                    </div>
                    <div class="card-body">
                    
                        <form action="registerAction.jsp" method="post" onsubmit="return validateRegForm()">
                            <div class="form-group">
                                <label for="fullName">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Enter your FullName">
                            </div>
                            <div class="form-group">
                                <label for="age">DOB</label>
                                <input type="date" class="form-control" id="dob" name="dob" placeholder="Enter your date of birth">
                            </div>
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email">
                            </div>
                            <div class="form-group">
    <label for="password">Password</label>
    <div class="input-group">
        <input type="password" class="form-control" id="password"  name="password" placeholder="Enter your password">
        <div class="input-group-append">
            <span class="input-group-text" onclick="togglePasswordVisibility('password', 'togglePasswordIcon')">
                <i class="bi bi-eye-slash" id="togglePasswordIcon"></i>
            </span>
        </div>
    </div>
</div>
<div class="form-group">
    <label for="confirmPassword">Confirm Password</label>
    <div class="input-group">
        <input type="password" class="form-control" id="confirmPassword" placeholder="Confirm your password">
        <div class="input-group-append">
            <span class="input-group-text" onclick="togglePasswordVisibility('confirmPassword', 'toggleConfirmPasswordIcon')">
                <i class="bi bi-eye-slash" id="toggleConfirmPasswordIcon"></i>
            </span>
        </div>
    </div>
</div>

                            <button type="submit" class="btn btn-primary btn-block">Register</button>
                        </form>
                    </div>
                    <div class="card-footer">
                        <small>Already have an account? <a href="login.jsp">Login here</a></small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>