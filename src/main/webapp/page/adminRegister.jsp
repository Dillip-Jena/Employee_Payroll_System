<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../component/links.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <%
        String errorMessage = request.getParameter("error");
    %>

    <title>Admin Registration</title>
    
    <style>
        body {
            background: linear-gradient(90deg, #004085, #0056b3);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-container {
            width: 100%;
            max-width: 550px;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }
        .header-label {
            background: #FFA07A;
            color: white;
            text-align: center;
            font-weight: bold;
            font-size: 22px;
            padding: 10px;
            border-radius: 10px 10px 0 0;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
        }
        .register-content {
            margin-top: 60px;
        }
        .alert {
            text-align: center;
        }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var errorAlert = document.getElementById("errorMessage");
            if (errorAlert) {
                setTimeout(function() {
                    errorAlert.style.opacity = "0";
                    setTimeout(function() {
                        errorAlert.style.display = "none";
                    }, 500);
                }, 4000);
            }
        });
        
        document.addEventListener("DOMContentLoaded", function() {
            var checkbox = document.getElementById("termsCheckbox");
            var registerForm = document.getElementById("registerForm");

            registerForm.addEventListener("submit", function(event) {
                if (!checkbox.checked) {
                    alert("You must agree to the Terms and Conditions before registering.");
                    event.preventDefault(); 
                }
            });
        });
    </script>
</head>
<body>

    <div class="register-container">
        <div class="header-label">Admin Registration</div>
        
        <div class="register-content">
            <h3 class="text-center mb-4">Create Admin Account</h3>

            <% if (errorMessage != null) { %>
                <div class="alert alert-danger" id="errorMessage">
                    <%= errorMessage %>
                </div>
            <% } %>

            <form id="registerForm" action="<%= request.getContextPath() %>/adminRegisterServlet" method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" class="form-control" name="name" id="name" placeholder="Enter your full name" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email ID</label>
                    <input type="email" class="form-control" name="email" id="email" placeholder="Enter your email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" id="password" placeholder="Create a password" required>
                </div>
                <div class="mb-3">
                    <label for="adminlogo" class="form-label">Profile Picture</label>
                    <input type="file" class="form-control" name="adminlogo" id="adminlogo" accept="image/*" required>
                </div>
                <div class="mb-3">
                    <label for="company" class="form-label">Company Name</label>
                    <input type="text" class="form-control" name="company" id="company" placeholder="Enter company name" required>
                </div>
                <div class="mb-3">
                    <label for="companylogo" class="form-label">Company Logo</label>
                    <input type="file" class="form-control" name="companylogo" id="companylogo" accept="image/*" required>
                </div>
                
                <div class="d-flex justify-content-center mb-3">
			        <div class="form-check">
			            <input class="form-check-input" type="checkbox" id="termsCheckbox">
			            <label class="form-check-label" for="termsCheckbox">
			                I agree to the <a href="#">Terms and Conditions</a>
			            </label>
			        </div>
			    </div>
                
                <div class="d-flex justify-content-center">
				    <button type="submit" id="registerBtn" class="btn btn-warning px-4 py-2" style="min-width: 150px;">
				        Register
				    </button>
				</div>
            </form>
        </div>
    </div>

</body>
</html>
