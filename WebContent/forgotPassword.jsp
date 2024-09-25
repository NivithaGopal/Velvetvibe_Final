<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <title>Reset Password - VELVETVIBE</title>
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
        .reset-password-container {
            max-width: 400px;
            width: 100%;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .reset-password-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .btn-custom {
            width: 100%;
            background-color: #343a40;
            border-color: #343a40;
            border-radius: 30px;
            padding: 10px 20px;
            font-size: 1.2rem;
            font-weight: bold;
            color: #fff;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            background-color: #495057;
            border-color: #495057;
        }
    </style>
    <script type="text/javascript">
        function validateForm() {
            var email = document.getElementById("email").value;
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;

            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$/;

            if (email == "") {
                alert("Email is required!");
                document.getElementById("email").focus();
                return false;
            }
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                document.getElementById("email").focus();
                return false;
            }
            if (newPassword == "") {
                alert("Please enter a new password!");
                document.getElementById("newPassword").focus();
                return false;
            }
            if (!passwordPattern.test(newPassword)) {
                alert("Password must be 8-12 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character.");
                document.getElementById("newPassword").focus();
                return false;
            }
            if (confirmPassword == "") {
                alert("Please confirm the new password!");
                document.getElementById("confirmPassword").focus();
                return false;
            }
            if (newPassword !== confirmPassword) {
                alert("Passwords do not match.");
                document.getElementById("confirmPassword").focus();
                return false;
            }
            return true;
        }

        function togglePasswordVisibility(fieldId) {
            var passwordField = document.getElementById(fieldId);
            var passwordIcon = document.getElementById(fieldId + "Icon");
            if (passwordField.type === "password") {
                passwordField.type = "text";
                passwordIcon.classList.remove("bi-eye-slash");
                passwordIcon.classList.add("bi-eye");
            } else {
                passwordField.type = "password";
                passwordIcon.classList.remove("bi-eye");
                passwordIcon.classList.add("bi-eye-slash");
            }
        }
    </script>
</head>
<body>
    <div class="reset-password-container">
        <div class="reset-password-header">
            <h3>Reset Password</h3>
            <p>Please enter your email and new password.</p>
        </div>
        <form action="updatePassword.jsp" method="post" onsubmit="return validateForm()">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" required>
                <div class="invalid-feedback">Please enter a valid email address.</div>
            </div>
            <div class="mb-3">
                <label for="newPassword" class="form-label">New Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    <span class="input-group-text" onclick="togglePasswordVisibility('newPassword')">
                        <i id="newPasswordIcon" class="bi bi-eye-slash"></i>
                    </span>
                </div>
                <div class="invalid-feedback">Please enter a new password.</div>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    <span class="input-group-text" onclick="togglePasswordVisibility('confirmPassword')">
                        <i id="confirmPasswordIcon" class="bi bi-eye-slash"></i>
                    </span>
                </div>
                <div class="invalid-feedback">Please confirm your password.</div>
            </div>
            <div class="d-flex justify-content-center mt-3">
                <button type="submit" class="btn btn-custom">Update Password</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
