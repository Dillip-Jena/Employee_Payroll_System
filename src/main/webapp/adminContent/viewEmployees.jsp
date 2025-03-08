<%@page import="com.model.Admin"%>
<%@ page import="java.util.*, com.dao.EmployeeDAO, com.model.Employee" %>

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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Employee List</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome (For Icons) -->
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
        img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #007bff;
        }
        .custom-head tr th{
        	background: #0056B3;
        	color: white;
        	font-size: 17px;
        }
        h2 {
            color: #333;
            font-weight: 600;
        }
        .btn-primary {
            background: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background: #0056b3;
        }
        .company-logo {
		    width: 100px;
		    height: 100px;
		    border-radius: 50%;
		    object-fit: cover;
		    border: 2px solid #007bff;
		}
    </style>
</head>
<body>

<div class="container">

	<!-- Company Logo and Name -->
    <div class="text-center mb-4">
        <img class="company-logo" src="<%= request.getContextPath() %>/imageServlet?adminId=<%= admin.getAdminId() %>&type=company_logo" alt="Company Logo" width="150" height="150">
        <h2 class="mt-2 text-primary"><%= admin.getCompany_name() %></h2>
    </div>

    <h3 class="text-center text-success mb-4"><i class="fas fa-users"></i> Employee List</h3>

    <div class="table-responsive">
        <table id="employeeTable" class="table table-hover">
            <thead class="custom-head">
                <tr>
                    <th>Employee ID</th>
                    <th>Profile</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Address</th>
                    <th>Joining Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Employee> employees = EmployeeDAO.getAllEmployees(admin.getAdminId());
                    for (Employee emp : employees) {
                %>
                <tr>
                    <td><%= emp.getEmpId() %></td>
                    <td>
                        <% 
                            if (emp.getProfilePic() != null) { 
                                response.setContentType("image/jpeg");
                                byte[] imageBytes = new byte[emp.getProfilePic().available()];
                                emp.getProfilePic().read(imageBytes);
                                String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        %>
                            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Profile">
                        <% } else { %>
                            <img src="default-avatar.png" alt="Default Profile">
                        <% } %>
                    </td>
                    <td><%= emp.getName() %></td>
                    <td><%= emp.getEmail() %></td>
                    <td><%= emp.getContact() %></td>
                    <td><%= emp.getAddress() %></td>
                    <td><%= emp.getJoiningDate() %></td>
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

<!-- jQuery (Required for DataTables) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

<script>
    $(document).ready(function () {
        $('#employeeTable').DataTable({
            "paging": true,
            "searching": true,
            "ordering": true,
            "info": true
        });
    });
</script>

</body>
</html>
