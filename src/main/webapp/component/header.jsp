<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <%@ include file="links.jsp" %> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
    <script>
	    $(document).ready(function() {
	        $(".dropdown-toggle").click(function() {
	            let bgColor = $(this).css("background-color"); // Get background color of the button
	            let width = $(this).outerWidth(); // Get width of the button including padding
	            
	            let dropdownMenu = $(this).next(".dropdown-menu");
	            dropdownMenu.css({
	                "background-color": bgColor, // Set background color dynamically
	                "min-width": width + "px" // Set dropdown width same as button
	            }).toggle();
	        });
	
	        // Hide dropdown when clicking outside
	        $(document).click(function(event) {
	            if (!$(event.target).closest(".dropdown").length) {
	                $(".dropdown-menu").hide();
	            }
	        });
	    });
    </script>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light header-container">
        <div class="container-fluid">
            <!-- Company Icon / Logo -->
            <a class="navbar-brand d-flex align-items-center" href="#">
               <i class="fa-solid fa-user-tie company-icon"></i> Employee Payroll System
            </a>
            
            <c:choose>
                <c:when test="${not empty admin}">
                    <!-- Admin Header -->
                    <div class="navbar-text mx-auto">
                        <h4>Welcome to Admin Dashboard</h4>
                    </div>
                    <div class="dropdown">
                        <div class="user-info dropdown-toggle">
                            <i class="fa-solid fa-user-shield"></i> <!-- Admin icon -->
                            <span><strong>${sessionScope.admin.name}</strong></span>
                        </div>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/component/changePassword.jsp?userType=admin&id=${sessionScope.admin.adminId}">
                            	<i class="fa-solid fa-key"></i> Change Password
                            </a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logoutServlet">
                            	<i class="fa-solid fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </div>
                </c:when>
                
                <c:when test="${not empty employee}">
                    <!-- Employee Header -->
                    <div class="navbar-text mx-auto">
                        <h4>Welcome to Employee Dashboard</h4>
                    </div>
                    <div class="dropdown">
                        <div class="user-info dropdown-toggle">
                            <i class="fa-solid fa-user"></i> <!-- Employee icon -->
                            <span><strong>${sessionScope.employee.name}</strong></span>
                        </div>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/component/changePassword.jsp?userType=employee&id=${sessionScope.employee.empId}">
                            	<i class="fa-solid fa-key"></i> Change Password
                            </a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logoutServlet">
                            	<i class="fa-solid fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <!-- Default Header -->
                    <div class="collapse navbar-collapse justify-content-center">
                        <ul class="navbar-nav">
                            <li class="nav-item"><a class="nav-links" href="#home">Home</a></li>
                            <li class="nav-item"><a class="nav-links" href="#about">About</a></li>
                            <li class="nav-item"><a class="nav-links" href="#">Contact Us</a></li>
                        </ul>
                    </div>
                    <div class="d-flex">
                        <a href="${pageContext.request.contextPath}/page/login.jsp?id=1" class="btn btn-primary me-2">Employee</a>
                        <a href="${pageContext.request.contextPath}/page/login.jsp?id=0" class="btn btn-warning">Admin</a>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </nav>

</body>
</html>
