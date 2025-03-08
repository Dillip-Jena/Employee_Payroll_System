<%@page import="java.sql.Date"%>
<%@ page import="com.model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");

    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/page/home.jsp");
        return;
    }

    String adminId = admin.getAdminId();
    String adminName = admin.getName();
    String companyName = admin.getCompany_name(); 
    String email = admin.getEmail(); 
    Date activationDate = admin.getActivation_date(); 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        .profile-pic {
            width: 150px;
            height: 180px;
            object-fit: cover;
            border-radius: 10%;
        }
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }
        .btn-custom {
            min-width: 70px;
            height: 40px;  /* Ensure both buttons have the same height */
   			padding: 10px 15px; 
        }
        #fileInput {
            display: none;
        }
    </style>
</head>
<body>

<%
    String successMessage = request.getParameter("success");
    String errorMessage = request.getParameter("error");
%>

<div class="container mt-5">
    <!-- Company Logo and Name -->
    <div class="text-center mb-4">
        <img src="<%= request.getContextPath() %>/imageServlet?adminId=<%= adminId %>&type=company_logo" alt="Company Logo" width="150">
        <h3 class="mt-2 text-primary"><%= companyName %></h3>
    </div>

    <div class="card shadow p-4">
        <div class="row">
            <!-- Left Section: Profile Picture & Buttons -->
            <div class="col-md-4 text-center">
                <img src="<%= request.getContextPath() %>/imageServlet?adminId=<%= adminId %>&type=profile_pic" alt="Profile Picture" class="profile-pic mb-3">

                <!-- Hidden File Input -->
                <form id="uploadForm" action="<%= request.getContextPath() %>/uploadProfilePicServlet" method="post" enctype="multipart/form-data">
                	<input type="hidden" name="userId" value="<%= adminId %>">
                	<input type="hidden" name="userType" value="admin">
                    <input type="file" name="profilePic" id="fileInput" onchange="document.getElementById('uploadForm').submit();">
                </form>

                <!-- Buttons: Update & Remove -->
                <div class="btn-container">
                    <button class="btn btn-primary btn-custom" onclick="document.getElementById('fileInput').click();">Update</button>
                    <form action="<%= request.getContextPath() %>/removeProfilePicServlet" method="post">
                    	<input type="hidden" name="userId" value="<%= adminId %>">
                    	<input type="hidden" name="userType" value="admin">
                        <button type="submit" class="btn btn-danger btn-custom">Remove</button>
                    </form>
                </div>
            </div>

            <!-- Right Section: Admin Details -->
            <div class="col-md-8">
                <h4 class="mb-3 text-primary text-center">Admin Information</h4>
                
                <% if (successMessage != null) { %>
				    <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
				        <%= successMessage %>
				        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				    </div>
				<% } %>
				
				<% if (errorMessage != null) { %>
				    <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
				        <%= errorMessage %>
				        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				    </div>
				<% } %>
                
                <table class="table table-bordered">
                    <tr>
                        <th>Admin Name</th>
                        <td><%= adminName %></td>
                    </tr>
                    <tr>
                        <th>Admin ID</th>
                        <td><%= adminId %></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><i class="fas fa-envelope"></i> <%= email %></td>
                    </tr>
                    <tr>
                        <th>Activation Date</th>
                        <td><%= activationDate %></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Admin Responsibilities Section -->
    <div class="card shadow p-4 mt-4">
        <h4 class="text-primary">Key Responsibilities</h4>
        <ul class="list-group">
            <li class="list-group-item"><i class="fas fa-check-circle text-success"></i> Manage users and access control</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success"></i> Oversee system operations and security</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success"></i> Maintain company data integrity</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success"></i> Generate reports and analytics</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success"></i> Ensure compliance with policies</li>
        </ul>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
