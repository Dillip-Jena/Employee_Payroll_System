<%@page import="com.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.model.Employee" %>

<%
    Employee employee = (Employee) session.getAttribute("employee");

    if (employee == null) {
        response.sendRedirect(request.getContextPath() + "/page/home.jsp");
        return;
    }
    
    String adminId = employee.getAdminId();
    String companyName = AdminDAO.getCompanyName(adminId);
	
    String successMessage = request.getParameter("success1");
    String errorMessage = request.getParameter("error1");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Raise a Problem</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px #ccc;
        }
    </style>

    <script>
        $(document).ready(function () {
            const successMessage = "<%= successMessage != null ? successMessage : "" %>";
            const errorMessage = "<%= errorMessage != null ? errorMessage : "" %>";

            if (successMessage) {
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: successMessage,
                    confirmButtonColor: '#3085d6',
                });
            } else if (errorMessage) {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: errorMessage,
                    confirmButtonColor: '#d33',
                });
            }
            
            $("#problemText").on("input", function () {
                var maxLength = 200;
                var textLength = $(this).val().length;

                if (textLength > maxLength) {
                    $(this).val($(this).val().substring(0, maxLength));
                    $("#charCount").text("200/200 characters");
                    Swal.fire({
                        icon: 'warning',
                        title: 'Character Limit Exceeded',
                        text: 'You can only enter up to 200 characters.',
                    });
                } else {
                    $("#charCount").text(textLength + "/200 characters");
                }
            });

            $("#problemForm").submit(function (e) {
                e.preventDefault();
                var problemText = $("#problemText").val().trim();

                if (problemText === "") {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Warning',
                        text: 'Please enter your problem before submitting.',
                    });
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "<%= request.getContextPath() %>/raiseProblemServlet",
                    data: { problemText: problemText },
                    success: function (response) {
                        if (response === "success") {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success!',
                                text: 'Your problem has been submitted successfully.',
                            }).then(() => {
                                window.location.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Failed to submit your problem. Please try again later.',
                            });
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>

<div class="container mt-3">

	<!-- Company Logo and Name -->
    <div class="text-center mb-4 mt-2">
    	<img src="<%= request.getContextPath() %>/imageServlet?adminId=<%= adminId %>&type=company_logo" alt="Company Logo" width="150">
        <h3 class="mt-2 text-primary"><%= companyName %></h3>
    </div>

    <h3 class="text-center">Raise a Problem</h3>

    <!-- Problem Form -->
    <form id="problemForm">
        <div class="mb-3">
		    <textarea id="problemText" name="problemText" class="form-control" rows="4" placeholder="Describe your problem here..." maxlength="200"></textarea>
		    <small id="charCount" class="text-muted">0/200 characters</small>
		</div>
        <div class="mt-3 d-flex justify-content-center">
        	<button type="submit" class="btn btn-primary" style="width: 100px;">Submit</button>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
