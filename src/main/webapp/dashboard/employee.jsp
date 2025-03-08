<%@ page import="com.model.Employee" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../component/links.jsp" %>

<%
    Employee employee = (Employee)session.getAttribute("employee");

    if(employee == null){
        response.sendRedirect(request.getContextPath()+"/page/home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Dashboard</title>

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
        }
        .main-container {
            display: flex;
            flex: 1;
            overflow: hidden;
        }
        .sidebar {
            width: 250px;
            background-color: #0056b3;
            color: white;
            padding-top: 20px;
            height: 100%;
            overflow-y: auto;
            position: relative;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background-color: #0056b3;
        }
        .sidebar-dropdown-menu {
            display: none;
            background-color: #004494;
        }
        .sidebar-dropdown-menu a {
            padding-left: 40px;
            font-size: 14px;
        }
        .sidebar-dropdown-menu.active {
            display: block;
        }
        .sidebar-dropdown-toggle::after {
            content: " ▼";
            font-size: 12px;
        }
        .content {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(document).ready(function () {
            // Get the 'page' parameter from the URL
            const urlParams = new URLSearchParams(window.location.search);
            const page = urlParams.get("page");

            const successMessage = urlParams.get("success1");
            const errorMessage = urlParams.get("error1");

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

            // Load page dynamically based on URL parameter or default
            if (page) {
                $("#main-content").load("../employeeContent/" + page + ".jsp");
            } else {
                $("#main-content").load("../employeeContent/employeeProfile.jsp");
            }

            // Sidebar dropdown toggle
            $(".sidebar-dropdown-toggle").click(function () {
                $(this).next(".sidebar-dropdown-menu").toggleClass("active");
            });

            // Load content dynamically on sidebar click
            $(".sidebar a").not("#logoutLink").click(function (e) {
                e.preventDefault();
                var page = $(this).attr("data-page");
                if (page) {
                    $("#main-content").load("../employeeContent/" + page + ".jsp");
                }
            });
        });
    </script>
</head>
<body>
    <%@ include file="../component/header.jsp" %>

    <div class="main-container">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <a href="#" data-page="employeeProfile"><i class="fas fa-user"></i> Employee Profile</a>

            <a href="#" data-page="attendance"><i class="fas fa-calendar-check"></i> Track Attendance</a>

            <a href="#" data-page="salarySlip"><i class="fas fa-file-invoice-dollar"></i> View Salary Slip</a>

            <a href="#" data-page="raiseProblem"><i class="fas fa-exclamation-circle"></i> Raise Problem</a>

            <a id="logoutLink" href="${pageContext.request.contextPath}/logoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <!-- Main Content Area -->
        <div class="content">
            <div id="main-content"></div> <!-- Content will be loaded here dynamically -->
        </div>
    </div>

    <%@ include file="../component/footer.jsp" %>
</body>
</html>
