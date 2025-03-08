<%@page import="com.model.Admin"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");

    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/page/home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Employee Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            max-width: 500px;
            margin: auto;
            margin-top: 50px;
        }
        .btn-sm {
            padding: 5px 10px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="container">

	<!-- Company Logo and Name -->
    <div class="text-center mb-4">
        <img class="company-logo" src="<%= request.getContextPath() %>/imageServlet?adminId=<%= admin.getAdminId() %>&type=company_logo" 
             alt="Company Logo" width="150">
        <h2 class="mt-2 text-primary"><%= admin.getCompany_name() %></h2>
    </div>

    <div class="card shadow p-3">
        <h5 class="card-title text-center">Employee Management</h5>
        
        <!-- Tabs -->
        <ul class="nav nav-tabs" id="employeeTabs">
            <li class="nav-item">
                <button class="nav-link active btn-sm" id="updateTab" data-bs-toggle="tab" data-bs-target="#updateSection">Update Job</button>
            </li>
            <li class="nav-item">
                <button class="nav-link btn-sm" id="resetTab" data-bs-toggle="tab" data-bs-target="#resetSection">Reset Password</button>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content mt-3">
            <!-- Update Job Details -->
            <div class="tab-pane fade show active" id="updateSection">
                <form id="updateForm">
                    <div class="mb-2">
                        <label class="form-label">Employee ID</label>
                        <input type="text" class="form-control form-control-sm" id="empId" required>
                    </div>
                    <div class="mb-2">
                        <label class="form-label">New Job Title</label>
                        <input type="text" class="form-control form-control-sm" id="jobTitle">
                    </div>
                    <div class="mb-2">
                        <label class="form-label">New Salary</label>
                        <input type="number" class="form-control form-control-sm" id="salary">
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-sm">Update</button>
                    </div>
                </form>
                <div id="updateResponse" class="mt-2 text-center"></div>
            </div>

            <!-- Reset Password -->
            <div class="tab-pane fade" id="resetSection">
                <form id="resetForm">
                    <div class="mb-2">
                        <label class="form-label">Employee ID</label>
                        <input type="text" class="form-control form-control-sm" id="empIdReset" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-danger btn-sm">Reset</button>
                    </div>
                </form>
                <div id="resetResponse" class="mt-2 text-center"></div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
$(document).ready(function () {

    // Reusable function to display messages
    function showMessage(container, message, type) {
        let msg = $('<div class="alert alert-' + type + '">' + message + '</div>');
        $(container).html(msg);
        setTimeout(function () {
            msg.fadeOut("slow", function () {
                $(this).remove();
            });
        }, 3000); // Disappear after 3 seconds
    }

    // Handle Update Job Details
    $("#updateForm").submit(function (event) {
        event.preventDefault();
        
        let empId = $("#empId").val();
        let jobTitle = $("#jobTitle").val();
        let salary = $("#salary").val();
        
        $.ajax({
            type: "POST",
            url: "<%= request.getContextPath() %>/saveOrUpdateEmpSalary",
            data: { empId: empId, jobTitle: jobTitle, salary: salary },
            success: function (response) {
                showMessage("#updateResponse", response, "success");
            },
            error: function (xhr) {
                showMessage("#updateResponse", xhr.responseText, "danger");
            }
        });
    });

    // Handle Reset Password
    $("#resetForm").submit(function (event) {
        event.preventDefault();
        
        let empId = $("#empIdReset").val();
        
        $.ajax({
            type: "POST",
            url: "<%= request.getContextPath() %>/resetEmpPassword",
            data: { empId: empId },
            success: function () {
                showMessage("#resetResponse", "Password Reset Successfully!", "success");
            },
            error: function () {
                showMessage("#resetResponse", "Error resetting password!", "danger");
            }
        });
    });

});
</script>

</body>
</html>
