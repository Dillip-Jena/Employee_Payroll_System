<%@page import="com.model.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
	Admin admin = (Admin)session.getAttribute("admin");

	if(admin == null){
		response.sendRedirect(request.getContextPath()+"/page/home.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Employee</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        .custom-form-container {
            max-width: 1000px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<%
    String successMessage1 = request.getParameter("success1");
    String errorMessage1 = request.getParameter("error1");
%>

<div class="container mt-5">

	<!-- Company Logo and Name -->
    <div class="text-center mb-4">
        <img src="<%= request.getContextPath() %>/imageServlet?adminId=<%= admin.getAdminId() %>&type=company_logo" alt="Company Logo" width="150">
        <h3 class="mt-2 text-primary"><%= admin.getCompany_name() %></h3>
    </div>

    <div class="custom-form-container">
        <h3 class="text-center text-primary"><i class="bi bi-person-plus-fill"></i> Add New Employee</h3>
        
        <form action="<%=request.getContextPath() %>/employeeRegisterServlet?admin_id=<%=admin.getAdminId() %>" method="post" enctype="multipart/form-data" class="mt-4">
            <table class="table">
                <!--<tr>
                    <th><i class="bi bi-person-badge"></i> Employee ID (6 chars) </th>
                    <td><input type="text" name="emp_id" class="form-control" maxlength="6" required></td>
                </tr>  -->
                <tr>
                    <th><i class="bi bi-person"></i> Name</th>
                    <td><input type="text" name="name" class="form-control"></td>
                </tr>
                <tr>
                    <th><i class="bi bi-envelope"></i> Email </th>
                    <td><input type="email" name="email" class="form-control" required></td>
                </tr>
                <tr>
                    <th><i class="bi bi-telephone"></i> Contact No.</th>
                    <td><input type="text" name="contact_no" class="form-control" required></td>
                </tr>
                <tr>
                    <th><i class="bi bi-house"></i> Address</th>
                    <td><textarea name="address" class="form-control" rows="3" required></textarea></td>
                </tr>
                <tr>
                    <th><i class="bi bi-calendar-check"></i> Joining Date</th>
                    <td><input type="date" name="joining_date" class="form-control"></td>
                </tr>
                <tr>
                    <th><i class="bi bi-image"></i> Profile Picture</th>
                    <td><input type="file" name="profile_pic" class="form-control"></td>
                </tr> 
            </table>

            <!-- Hidden Fields -->
            <input type="hidden" name="password" value="default123">

            <div class="text-center">
                <button type="submit" class="btn btn-success">Submit</button>
                <button type="reset" class="btn btn-secondary">Reset</button>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
