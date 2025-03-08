<%@page import="com.dao.ProblemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Complaint" %>
<%@ page import="com.model.Admin" %>
<%@ include file="../component/links.jsp" %>

<%
    // Get the logged-in admin from the session
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/page/home.jsp");
        return;
    }

    String adminId = admin.getAdminId();
    List<Complaint> complaints = ProblemDAO.getComplaints(adminId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
    	.custom-head th {
            background: #0056B3 !important;
            color: white !important;
            font-size: 17px !important;
        }
    </style>
</head>
<body>

<div class="container mt-5">

	<!-- Company Logo and Name -->
    <div class="text-center mb-4">
        <img class="company-logo" src="<%= request.getContextPath() %>/imageServlet?adminId=<%= admin.getAdminId() %>&type=company_logo" 
             alt="Company Logo" width="150" >
        <h2 class="mt-2 text-primary"><%= admin.getCompany_name() %></h2>
    </div>

    <h3 class="text-center text-danger">Employee Complaints</h3>

    <div class="table-responsive mt-4">
        <table class="table table-bordered">
            <thead class="custom-head">
                <tr>
                    <th>Employee ID</th>
                    <th>Complaint</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (complaints.isEmpty()) {
                %>
                    <tr>
                        <td colspan="3" class="text-center text-danger">No complaints found for your account</td>
                    </tr>
                <%
                    } else {
                        for (Complaint complaint : complaints) {
                %>
                    <tr>
                        <td><%= complaint.getEmpId() %></td>
                        <td><%= complaint.getProblemText() %></td>
                        <td><%= complaint.getComplaintDate() %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/DeleteComplaintServlet" method="post">
                                <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                                <button type="submit" class="btn btn-success btn-sm">Resolved</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
