<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../component/links.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <%
        // Fetching the id parameter from the URL
        String idParam = request.getParameter("id");
    	String errorMessage = request.getParameter("error");
        int id = (idParam != null) ? Integer.parseInt(idParam) : 1; 

        // Defining dynamic content based on id
        String userType = (id == 0) ? "Admin" : "Employee";
        String bgColor = (id == 0) ? "#ff6b6b" : "#90EE90"; 
    %>

    <title><%= userType %> Login Page</title>
    <style>
        body {
            background: linear-gradient(90deg, #004085, #0056b3);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            width: 100%;
            max-width: 500px;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }
        .header-label {
            background: <%= bgColor %>;
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
        .login-content {
            margin-top: 60px; 
        }
        .login-title {
            font-size: 20px;
            font-weight: 600;
        }
        .button-container {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .btn-custom {
            width: 25%;
            transition: 0.3s;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            padding: 10px 20px;
            text-align: center;
        }
        .btn-custom i {
            margin-right: 8px;
        }
        .btn-login:hover {
            background-color: #003366;
        }
        .bx {
            font-size: 20px;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Get the error message element
            var errorAlert = document.getElementById("errorMessage");
            if (errorAlert) {
                // Set timeout to hide error message after 4 seconds
                setTimeout(function() {
                    errorAlert.style.opacity = "0";
                    setTimeout(function() {
                        errorAlert.style.display = "none";
                    }, 500); // Allow the fade-out effect to complete
                }, 4000);
            }
        });
    </script>
</head>
<body>

    <div class="login-container">
        <div class="header-label">Employee Payroll System</div> 
        <div class="login-content">
            <h3 class="text-center mb-4 login-title"><%= userType %> Login</h3>
            
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger text-center" id="errorMessage">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <form id="loginForm" action="<%= request.getContextPath() %>/<%= (id == 0) ? "adminLoginServlet" : "employeeLoginServlet" %>" method="POST">
                <div class="mb-3">
                    <label for="id" class="form-label"><%= userType %> ID</label>
                    <input type="text" class="form-control" name="id" id="id" placeholder="Enter your ID" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email ID</label>
                    <input type="email" class="form-control" name="email" id="email" placeholder="Enter your email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" id="password" placeholder="Enter your password" required>
                </div>
                <div class="button-container">
                    <button type="button" class="btn btn-danger btn-custom" onclick="history.back()">
                        <i class='bx bx-right-arrow-alt bx-rotate-180'></i> Back
                    </button>
                    <button type="submit" class="btn btn-primary btn-custom">
                        Login <i class='bx bx-right-arrow-alt'></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
