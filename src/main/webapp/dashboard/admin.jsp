<%@ page import="com.model.Admin" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../component/links.jsp" %>

<%
	Admin admin = (Admin)session.getAttribute("admin");

	if(admin == null){
		response.sendRedirect(request.getContextPath()+"/page/home.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Admin Dashboard</title>
    
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
            background-color: #004494;
        }
        .sidebar-dropdown-menu {
            display: none;
            background-color: #003366;
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
            console.log("Success Message: ", successMessage);

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

            // If 'page' parameter exists, load the respective page, otherwise load the default page
            if (page) {
                $("#main-content").load("../adminContent/" + page + ".jsp");
            } else {
                $("#main-content").load("../adminContent/adminprofile.jsp");
            }

            // Sidebar dropdown toggles
            $(".sidebar-dropdown-toggle").click(function () {
                $(this).next(".sidebar-dropdown-menu").toggleClass("active");
            });

            // Load content dynamically on click
            $(".sidebar a").not("#logoutLink").click(function (e) {
                e.preventDefault();
                var page = $(this).attr("data-page"); // Get the page name from data attribute
                if (page) {
                    $("#main-content").load("../adminContent/" + page + ".jsp");
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
            <a href="#" data-page="adminprofile"><i class="fas fa-user"></i> Admin Profile</a>

            <!-- Manage Employees Dropdown -->
            <a class="sidebar-dropdown-toggle"><i class="fas fa-users"></i> Manage Employees</a>
            <div class="sidebar-dropdown-menu">
                <a href="#" data-page="viewEmployees"><i class="fas fa-eye"></i> View Employees</a>
                <a href="#" data-page="addEmployee"><i class="fas fa-user-plus"></i> Add Employee</a>
                <a href="#" data-page="edit&deleteEmployee"><i class="fas fa-tasks"></i> Edit &amp; Delete Employee</a>
            </div>

            <!-- Reports Dropdown -->
            <a class="sidebar-dropdown-toggle"><i class="fas fa-chart-line"></i> Reports</a>
            <div class="sidebar-dropdown-menu">
                <a href="#" data-page="attendanceReport"><i class="fas fa-calendar-check"></i> Attendance Reports</a>
                <a href="#" data-page="markAttendence"><i class="fas fa-chart-bar"></i> Mark Attendence</a>
            </div>
			
			<a href="#" data-page="complaints"><i class="fas fa-comments"></i> Employee Complaints</a>
            <a href="#" data-page="settings"><i class="fas fa-cog"></i> Settings</a>
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
