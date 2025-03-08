<%@page import="com.dao.JobDAO"%>
<%@page import="com.model.JobDetails"%>
<%@page import="com.model.Admin"%>
<%@ page import="java.util.*, com.dao.EmployeeDAO, com.model.Employee" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");

    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/page/home.jsp");
        return;
    }
    
    Calendar cal = Calendar.getInstance();
    int currentYear = cal.get(Calendar.YEAR);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Attendance Report</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">

    <style>
        body {
            background: #f4f7fc;
            font-family: 'Poppins', sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .table-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .custom-head th {
            background: #0056B3 !important;
            color: white !important;
            font-size: 17px !important;
        }
        .btn-save, .btn-calculate {
            width: 100px;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-save {
            background: #28a745;
            color: white;
        }
        .btn-save:hover {
            background: #218838;
        }
        .btn-calculate {
            background: #ffc107;
            color: black;
        }
        .btn-calculate:hover {
            background: #e0a800;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        /* Increase Action Column Width */
        th:nth-child(8), td:nth-child(8) {
            width: 200px !important;
        }
        th:nth-child(8){
        	text-align: center !important;
        }
    </style>
</head>
<body>

<div class="container">

    <!-- Company Logo and Name -->
    <div class="text-center mb-4">
        <img class="company-logo" src="<%= request.getContextPath() %>/imageServlet?adminId=<%= admin.getAdminId() %>&type=company_logo" 
             alt="Company Logo" width="150" >
        <h2 class="mt-2 text-primary"><%= admin.getCompany_name() %></h2>
    </div>

    <!-- Page Title -->
    <h3 class="text-center text-success mb-4"><i class="fas fa-file-alt"></i> Attendance Report</h3>

    <div class="table-container">
        <table id="attendanceTable" class="table table-hover">
            <thead class="custom-head">
                <tr>
                    <th>Employee ID</th>
                    <th>Name</th>
                    <th>Job Title</th>
                    <th>Days</th>
                    <th>Month</th>
                    <th>Year</th>
                    <th>Salary</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Employee> employees = EmployeeDAO.getAllEmployees(admin.getAdminId());
                    for (Employee emp : employees) {
                    	JobDetails detail = JobDAO.getJobDetails(emp.getEmpId());
                    	String jobTitle = (detail != null) ? detail.getJobTitle() : "Not Assigned";
                    	double salary = (detail != null) ? detail.getSalary() : 0.0;
                %>
                <tr data-id="<%= emp.getEmpId() %>">
                    <td><%= emp.getEmpId() %></td>
                    <td><%= emp.getName() %></td>
                    <td><%= jobTitle %></td>
                    <td><input type="number" class="form-control days-input" value="0" min="0"></td>
                    <td>
                        <select class="form-select month-select">
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
                    </td>
                    <td><input type="number" class="form-control year-input" value="<%= currentYear %>" min="2000"></td>
                    <td><input type="number" class="form-control salary-input" value="<%= salary %>" readonly></td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-calculate"><i class="fas fa-calculator"></i> Calculate</button>
                            <button class="btn btn-save"><i class="fas fa-save"></i> Save</button>
                        </div>
                    </td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

<script>
	$(document).ready(function () {
	    $('#attendanceTable').DataTable();
	
	    // Calculate attendance and salary
	    $('.btn-calculate').click(function () {
	        let row = $(this).closest('tr');
	        let empId = row.data('id');
	        let month = row.find('.month-select').val();
	        let year = row.find('.year-input').val();
	
	        if (year < 2000) {
	            alert("Invalid Year");
	            return;
	        }
	
	        console.log("Sending Data for Calculation: ", { empId, month, year });
	
	        $.ajax({
	            url: "<%= request.getContextPath() %>/attendanceReport",
	            type: 'POST',
	            data: { empId: empId, month: month, year: year },
	            dataType: 'json',
	            success: function (response) {
	                if (response.success) {
	                    row.find('.days-input').val(response.daysPresent);
	                    row.find('.salary-input').val(response.totalSalary);
	                } else {
	                    alert('Error: ' + response.message);
	                }
	            },
	            error: function () {
	                alert('Error calculating salary.');
	            }
	        });
	    });
	    
	 	// Save attendance record to the database
	    $('.btn-save').click(function () {
	        let row = $(this).closest('tr');
	        let empId = row.data('id');
	        let days = row.find('.days-input').val();
	        let month = row.find('.month-select').val();
	        let year = row.find('.year-input').val();
	        let salary = row.find('.salary-input').val();

	        if (days < 0 || year < 2000) {
	            alert("Invalid data. Please check the inputs.");
	            return;
	        }
	        
	        $.ajax({
	            url: "<%= request.getContextPath() %>/saveAttendanceServlet",
	            type: 'POST',
	            data: {
	                empId: empId,
	                adminId: '<%= admin.getAdminId() %>', // Send adminId as well
	                days: days,
	                month: month,
	                year: year,
	                salary: salary
	            },
	            success: function (response) {
	                if (response === "success") {
	                    alert("Attendance record saved successfully!");
	                } else {
	                    alert("Error saving record: " + response);
	                }
	            },
	            error: function () {
	                alert("Error while saving attendance.");
	            }
	        });
	    });
	});

</script>

</body>
</html>
