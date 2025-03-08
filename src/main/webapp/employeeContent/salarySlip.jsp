<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.dao.AdminDAO"%>
<%@ page import="com.model.Employee, com.model.SalarySlip" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Employee employee = (Employee) session.getAttribute("employee");

    if (employee == null) {
        response.sendRedirect(request.getContextPath() + "/page/home.jsp");
        return;
    }
    
    String employeeId = employee.getEmpId();
    String adminId = employee.getAdminId();
    String companyName = AdminDAO.getCompanyName(adminId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Salary Slip</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
        .salary-slip {
            margin-top: 20px;
            padding: 20px;
            background: #fff;
            border: 2px solid #007bff;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 123, 255, 0.2);
        }
        .salary-slip h3 {
            text-align: center;
            background: #007bff;
            color: white;
            padding: 12px;
            border-radius: 5px;
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>

<div class="container mt-3">

	<!-- Company Logo and Name -->
    <div class="text-center mb-4">
    	<img src="<%= request.getContextPath() %>/imageServlet?adminId=<%= adminId %>&type=company_logo" alt="Company Logo" width="150">
        <h3 class="mt-2 text-primary"><%= companyName %></h3>
    </div>

    <h3 class="text-center mb-4">Generate Salary Slip</h3>

    <form action="<%= request.getContextPath() %>/salarySlipServlet" method="post" >
        <div class="d-flex gap-3 mb-3">
        	<div class="flex-fill">
	            <label for="emp_id" class="form-label">Employee ID:</label>
	            <input type="text" class="form-control" id="emp_id" name="emp_id" value="<%= employee.getEmpId() %>" readonly>
	        </div>
	
	        <div class="flex-fill">
	            <label for="month" class="form-label">Month:</label>
	            <select class="form-select" id="month" name="month" required>
	                <option value="">Select Month</option>
	                <option value="January">January</option>
	                <option value="February">February</option>
	                <option value="March">March</option>
	                <option value="April">April</option>
	                <option value="May">May</option>
	                <option value="June">June</option>
	                <option value="July">July</option>
	                <option value="August">August</option>
	                <option value="September">September</option>
	                <option value="October">October</option>
	                <option value="November">November</option>
	                <option value="December">December</option>
	            </select>
	        </div>
	
	        <div class="flex-fill">
	            <label for="year" class="form-label">Year:</label>
	            <input type="number" class="form-control" id="year" name="year" value="<%= java.time.Year.now() %>" required>
	        </div>
        </div>

        <div class="mt-3 d-flex justify-content-center">
        	<button type="submit" class="btn btn-primary" style="width: 150px;">Generate</button>
        </div>
    </form>

    <%
        SalarySlip salarySlip = (SalarySlip) session.getAttribute("salarySlip");
        if (salarySlip != null) {
    %>
        <!-- Centered Salary Slip -->
		<div class="d-flex justify-content-center mt-4">
		    <div class="card salary-slip shadow-lg border-0" style="max-width: 550px; width: 100%; font-family: Arial, sans-serif;">
		        <!-- Header -->
		        <div class="card-header bg-success text-white text-center py-3">
		            <h4 class="mb-0">Salary Slip</h4>
		            <small><%= salarySlip.getMonth() %> <%= salarySlip.getYear() %></small>
		        </div>
		
		        <!-- Body -->
		        <div class="card-body p-4">
		            <div class="row align-items-center">
		                <!-- Profile Picture -->
		                <div class="col-6 text-center">
		                    <img src="<%= request.getContextPath() %>/imageServlet?employeeId=<%= employeeId %>&type=profile_pic"
		                        alt="Profile Picture" class="rounded-circle border shadow-sm" style="width: 80px; height: 80px;">
		                </div>
		                <!-- Employee Info -->
		                <div class="col-6">
		                    <h6 class="mb-0"><strong><%= employee.getName() %></strong></h6>
		                    <p class="text-muted mb-0"><%= JobDAO.getJobTitle(employeeId) %></p>
		                    <small class="text-muted"><%= companyName %></small>
		                </div>
		            </div>
		
		            <hr>
		
		            <!-- Salary Details -->
		            <table class="table table-sm">
		                <tbody>
		                    <tr>
		                        <th class="text-muted">Employee ID</th>
		                        <td class="text-end"><%= employee.getEmpId() %></td>
		                    </tr>
		                    <tr>
		                        <th class="text-muted">Email</th>
		                        <td class="text-end"><%= employee.getEmail() %></td>
		                    </tr>
		                    <tr>
		                        <th class="text-muted">Month</th>
		                        <td class="text-end"><%= salarySlip.getMonth() %></td>
		                    </tr>
		                    <tr>
		                        <th class="text-muted">Year</th>
		                        <td class="text-end"><%= salarySlip.getYear() %></td>
		                    </tr>
		                    <tr>
		                        <th class="text-muted">Working Days</th>
		                        <td class="text-end"><%= salarySlip.getDays() %></td>
		                    </tr>
		                    <tr class="bg-light">
		                        <th><strong>Salary Amount</strong></th>
		                        <td class="text-end text-success"><strong>₹ <%= salarySlip.getSalary() %></strong></td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		
		        <!-- Footer -->
		        <div class="d-flex justify-content-center">
		            <%
					    String pdfUrl = request.getContextPath() + "/generateSalarySlipPDF?"
					    		+ "admin_id=" + employee.getAdminId()
					            + "&emp_id=" + employee.getEmpId()
					            + "&emp_name=" + employee.getName()
					            + "&email=" + employee.getEmail()
					            + "&job_title=" + JobDAO.getJobTitle(employeeId)
					            + "&company_name=" + companyName
					            + "&month=" + salarySlip.getMonth()
					            + "&year=" + String.valueOf(salarySlip.getYear())
					            + "&days=" + String.valueOf(salarySlip.getDays())
					            + "&salary=" + String.valueOf(salarySlip.getSalary());
					%>
					<a href="<%= pdfUrl %>" class="btn btn-danger btn-sm">Download PDF</a>
		        </div>
		    </div>
		</div>
        
    <%
            session.removeAttribute("salarySlip"); 
        }
    %>

</div>

<!-- Bootstrap JS (for dropdowns, validations, etc.) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
