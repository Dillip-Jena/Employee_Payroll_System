<%@page import="com.model.Admin"%>
<%@ page import="java.util.*, com.dao.EmployeeDAO, com.model.Employee" %>

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
    <title>Employee Attendance</title>

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
        .table-responsive {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .custom-head tr th {
            background: #0056B3;
            color: white;
            font-size: 17px;
        }
        .btn-save {
            background: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-save:hover {
            background: #218838;
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
    <h3 class="text-center text-success mb-4"><i class="fas fa-user-check"></i> Mark Attendance</h3>

    <!-- Date Input Field -->
    <div class="row mb-3">
        <div class="col-md-4">
            <label for="attendanceDate" class="form-label fw-bold">Select Date:</label>
            <input type="date" id="attendanceDate" name="date" class="form-control" required>
        </div>
    </div>

    <div class="table-responsive">
        <table id="employeeTable" class="table table-hover">
            <thead class="custom-head">
                <tr>
                    <th>Employee ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Attendance</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Employee> employees = EmployeeDAO.getAllEmployees(admin.getAdminId());
                    for (Employee emp : employees) {
                %>
                <tr data-id="<%= emp.getEmpId() %>">
                    <td><%= emp.getEmpId() %></td>
                    <td><%= emp.getName() %></td>
                    <td><%= emp.getEmail() %></td>
                    <td>
                        <select class="form-select attendance-status">
                            <option value="">Select</option>
                            <option value="Present">Present</option>
                            <option value="Absent">Absent</option>
                            <option value="Leave">Leave</option>
                        </select>
                    </td>
                    <td>
                        <button class="btn btn-save"><i class="fas fa-save"></i> Save</button>
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

<!-- Define contextPath -->
<script>
    var contextPath = "<%= request.getContextPath() %>";
</script>

<script>
    $(document).ready(function () {
        $('#employeeTable').DataTable();

        // Set today's date as default
        var today = new Date().toISOString().split('T')[0];
        document.getElementById("attendanceDate").value = today;

        // Save attendance for each employee
        $('.btn-save').click(function () {
            let row = $(this).closest('tr');
            let empId = row.data('id');
            let attendanceDate = $('#attendanceDate').val();
            let status = row.find('.attendance-status').val();

            if (!status) {
                alert("Please select attendance status.");
                return;
            }
            
            console.log("Sending Data: ", { empId, date: attendanceDate, status });

            $.ajax({
                url: contextPath + '/attendanceServlet',
                type: 'POST',
                data: { empId: empId, date: attendanceDate, status: status }, // Sending data in form-urlencoded format
                success: function (response) {
                    if (response.trim() === "updated") {
                        alert('Attendance updated successfully!');
                    } else if (response.trim() === "inserted") {
                        alert('Attendance saved successfully!');
                    } else {
                        alert('Error: ' + response);
                    }
                },
                error: function () {
                    alert('Error saving attendance.');
                }
            });
        });
    });
</script>

</body>
</html>
