<%@page import="com.dao.AdminDAO"%>
<%@page import="com.model.Employee"%>
<%@page import="java.util.List"%>
<%@page import="com.model.Attendance"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Employee employee = (Employee)session.getAttribute("employee");

    if(employee == null){
        response.sendRedirect(request.getContextPath()+"/page/home.jsp");
        return;
    }
    
    String empId = (employee != null) ? employee.getEmpId() : "";
    String adminId = employee.getAdminId();
    String companyName = AdminDAO.getCompanyName(adminId);
%>

<html>
<head>
    <title>Employee Attendance</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
	    .custom-head th {
            background: #0056B3 !important;
            color: white !important;
            font-size: 17px !important;
        }
	</style>
</head>
<body>
	<div class="container mt-5">
	
		<!-- Employee Profile Picture and Name -->
	    <div class="text-center mb-4">
	    	<img src="<%= request.getContextPath() %>/imageServlet?adminId=<%= adminId %>&type=company_logo" alt="Company Logo" width="150">
	        <h3 class="mt-2 text-primary"><%= companyName %></h3>
	    </div>
	
		<h2 class="mb-4 text-center">Attendance Record</h2>

	    <!-- Form to enter Employee ID and Month -->
	    <form action="<%= request.getContextPath() %>/employeeAttendance" method="get" class="row g-3">
	        <div class="col-md-3">
	            <input type="text" name="empId" class="form-control" value="<%= empId %>" readonly>
	        </div>
	        <div class="col-md-3">
	            <select name="month" class="form-control" required>
	                <option value="">Select Month</option>
	                <% for (int i = 1; i <= 12; i++) { %>
	                    <option value="<%= i %>"><%= i %></option>
	                <% } %>
	            </select>
	        </div>
	        <div class="col-md-3">
	            <input type="number" name="year" class="form-control" placeholder="Year" required>
	        </div>
	        <div class="col-md-3">
	            <button type="submit" class="btn btn-primary">View Attendance</button>
	        </div>
	    </form>
	
	    <%
	        List<Attendance> attendanceList = (List<Attendance>) session.getAttribute("attendanceList");
	        if (attendanceList != null && !attendanceList.isEmpty()) {
	    %>
	        <table class="table table-bordered mt-4">
	            <thead class="custom-head">
	                <tr>
	                    <th>Date</th>
	                    <th>Status</th>
	                </tr>
	            </thead>
	            <tbody>
	                <% for (Attendance att : attendanceList) { %>
	                    <tr>
	                        <td><%= att.getAttendenceDate() %></td>
	                        <td>
	                            <% if (att.getStatus().equals("Present")) { %>
	                                <span class="badge bg-success">Present</span>
	                            <% } else if (att.getStatus().equals("Absent")) { %>
	                                <span class="badge bg-danger">Absent</span>
	                            <% } else { %>
	                                <span class="badge bg-warning">Leave</span>
	                            <% } %>
	                        </td>
	                    </tr>
	                <% } %>
	            </tbody>
	        </table>
	    <% } else if (request.getParameter("empId") != null && request.getParameter("month") != null && request.getParameter("year") != null) { %>
	        <p class="mt-4 text-danger">No attendance records found for the selected month.</p>
	    <% } %>
	</div>
</body>
</html>
