<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if user is logged in
    if (session.getAttribute("admin") == null && session.getAttribute("employee") == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }
    
    String userType = request.getParameter("userType");
    String userId = request.getParameter("id");
    
    String errorMsg = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <%@ include file="links.jsp" %>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
        <div class="card shadow-lg p-4" style="width: 400px; border-radius: 10px;">
            <h3 class="text-center mb-4">Change Password</h3>
            
            <% if (errorMsg != null) { %>
			    <div class="alert alert-danger text-center" id="errorMessage">
			        <%= errorMsg %>
			    </div>
			<% } %>
            
            <form action="<%= request.getContextPath() %>/changePasswordServlet" method="post" class="d-flex flex-column align-items-center">
                <input type="hidden" name="userType" value="<%= userType %>">
                <input type="hidden" name="userId" value="<%= userId %>">
                
                <div class="mb-3 w-100">
                    <label class="form-label"><i class="fas fa-lock"></i> Old Password:</label>
                    <input type="password" name="oldPassword" class="form-control" placeholder="Enter old password" required>
                </div>
                
                <div class="mb-3 w-100">
                    <label class="form-label"><i class="fas fa-key"></i> New Password:</label>
                    <input type="password" name="newPassword" class="form-control" placeholder="Enter new password" required>
                </div>
                
                <div class="d-flex justify-content-between w-100 mt-3">
                    <a href="javascript:history.back()" class="btn btn-danger" style="width: 25%;"><i class="fas fa-arrow-left"></i> Back</a>
                    <button type="submit" class="btn btn-primary" style="width: 55%;"><i class="fas fa-edit"></i> Change Password</button>
                </div>
            </form>
        </div>
    </div>
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
</body>
</html>
