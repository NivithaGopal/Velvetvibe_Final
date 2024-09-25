<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <title>Login - VELVETVIBE</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
            color: #333;
        }

        .login-container {
            max-width: 400px;
            width: 100%;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .login-header {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .login-header h3 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #212529;
        }

        .login-header p {
            color: #6c757d;
            font-size: 1rem;
        }

        .btn-custom {
            width: 100%;
            background-color: #343a40;
            border-color: #343a40;
            border-radius: 30px;
            padding: 10px 20px;
            font-size: 1.2rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #495057;
            border-color: #495057;
        }

        .input-group-text {
            cursor: pointer;
            background-color: transparent;
            border: none;
            color: #495057;
        }

        .form-label {
            font-weight: bold;
            color: #495057;
        }

        .form-control {
            border-radius: 10px;
            padding: 15px;
            font-size: 1rem;
            background: #f8f9fa;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
            border: 1px solid #ced4da;
        }

        .text-muted {
            color: #6c757d !important;
        }

        .text-end a, .text-center a {
            color: #343a40;
            font-weight: bold;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .text-end a:hover, .text-center a:hover {
            color: #495057;
        }
    </style>

    <script type="text/javascript">
        function validateform() {
            var email = document.getElementById("email").value;
            var password = document.getElementById("password").value;

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
            return true;
        }

        function togglePasswordVisibility() {
            var passwordField = document.getElementById("password");
            var toggleIcon = document.getElementById("togglePasswordIcon");
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
    <div class="login-container">
        <div class="login-header">
            <h3>VELVETVIBE</h3>
            <p class="text-muted">Please login to your account</p>
        </div>
        <form action="loginAction.jsp" method="post" onsubmit="return validateform()">
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Email ID</label>
                <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp">
                <div id="emailHelp" class="form-text">By continuing, you agree to VelvetVibe's Terms of Use and Privacy Policy.</div>
            </div>
            <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password">
                    <span class="input-group-text" onclick="togglePasswordVisibility()">
                        <i class="bi bi-eye-slash" id="togglePasswordIcon"></i>
                    </span>
                </div>
            </div>
            <div class="text-end mt-3">
                <a href="forgotPassword.jsp">Forgot your password?</a>
            </div>

            <br>

            <div class="d-flex justify-content-center mt-3">
                <input type="submit" value="Sign in" class="btn btn-custom">
            </div>
            <div class="text-center mt-3">
                <a href="registration.jsp">No account yet? Create one</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
    